const { query } = await Service.import("applications");
const network = await Service.import("network");
const audio = await Service.import("audio");
const WINDOW_NAME = "launcher";

async function getMemory() {
    const total = await Utils.execAsync(
        `bash -c "free -b | rg Mem | awk '{print $2}'"`,
    );
    const used = await Utils.execAsync(
        `bash -c "free -b | rg Mem | awk '{print $3}'"`,
    );

    return parseFloat(used) / parseFloat(total);
}

const Memory = () => {
    return Widget.CircularProgress({
        class_name: "progress",
        value: 0,
        rounded: true,
    }).poll(5000, (self) => {
        getMemory().then((mem) => {
            self.value = mem;
            self.tooltip_text = `Memory: ${(mem * 100).toPrecision(3)}%`;
        });
    });
};

const InfoPanel = Widget.Box({
    hpack: "fill",
    children: [
        Widget.Box({
            children: [Memory()],
        }),
        Widget.Box({
            hpack: "center",
            hexpand: true,
            children: [
                Widget.Label({
                    class_name: "time",
                }).poll(
                    1000,
                    (self) =>
                        (self.label = Utils.exec(`date '+%a %d.%m %H:%M'`)),
                ),
            ],
        }),
        Widget.Box({
            spacing: 6,
            children: [
                Widget.Icon({
                    icon: Utils.merge(
                        [
                            network.bind("primary"),
                            network.wired.bind("icon_name"),
                            network.wifi.bind("icon_name"),
                        ],
                        (primary, wired, wireless) => {
                            return primary == "wired" ? wired : wireless;
                        },
                    ),
                    size: 20,
                    tooltip_text: network.wifi
                        .bind("ssid")
                        .as((ssid) => ssid ?? ""),
                }),
                Widget.Button({
                    class_name: "notheme",
                    child: Widget.Icon({
                        cursor: "pointer",
                        icon: Utils.merge(
                            [
                                audio.speaker.bind("volume"),
                                audio.speaker.bind("is_muted"),
                            ],
                            (volume, muted) => {
                                if (muted) {
                                    return "audio-volume-muted-symbolic";
                                } else if (volume > 0.6) {
                                    return "audio-volume-high-symbolic";
                                } else if (volume > 0.4) {
                                    return "audio-volume-medium-symbolic";
                                } else {
                                    return "audio-volume-low-symbolic";
                                }
                            },
                        ),
                        tooltip_text: audio.speaker
                            .bind("volume")
                            .as((vol) => `Volume: ${vol}%`),
                        size: 20,
                    }),
                    on_clicked: () => {
                        Utils.execAsync("pavucontrol");
                        App.closeWindow(WINDOW_NAME);
                    },
                    on_scroll_up: () => {
                        Utils.execAsync(
                            "pactl set-sink-volume @DEFAULT_SINK@ +5%",
                        );
                    },
                    on_scroll_down: () => {
                        Utils.execAsync(
                            "pactl set-sink-volume @DEFAULT_SINK@ -5%",
                        );
                    },
                }),
            ],
        }),
    ],
});

/** @param {import('resource:///com/github/Aylur/ags/service/applications.js').Application} app */
const AppButton = (app) =>
    Widget.Button({
        on_clicked: () => {
            App.closeWindow(WINDOW_NAME);
            app.launch();
        },
        cursor: "pointer",
        className: "launcher_button",
        attribute: { app },
        child: Widget.Box({
            spacing: 12,
            children: [
                Widget.Icon({
                    icon: app.icon_name || "",
                    size: 60,
                }),
                Widget.Box({
                    vertical: true,
                    children: [
                        Widget.Label({
                            label: app.name,
                            class_name: "primary_label",
                            justification: "left",
                            xalign: 0,
                        }),
                        Widget.Label({
                            label: app.description,
                            class_name: "subtext",
                            truncate: "end",
                            xalign: 0,
                        }),
                    ],
                }),
            ],
        }),
    });

const HIST_SIZE = 100;
class History {
    /** @type {string[]} */
    #data = [];
    /** @type {number | null} */
    #selected = null;
    /** @type {string | null} */
    #latest = null;

    /** @param {string} item */
    insert(item) {
        this.#data = this.#data.filter((x) => x != item);

        this.#data.push(item);
        if (this.#data.length > HIST_SIZE) this.#data.shift();
        this.#selected = null;
        this.#latest = null;
    }

    /** @param {string | null} [latest=null]  */
    previous(latest = null) {
        if (this.#data.length == 0) {
            return null;
        }

        if (latest != null && this.#latest == null) {
            this.#latest = latest;
        }

        if (this.#selected == null) {
            this.#selected = this.#data.length - 1;
        } else {
            this.#selected = Math.max(0, this.#selected - 1);
        }

        return this.#data[this.#selected];
    }

    next() {
        if (this.#selected == null) {
            return null;
        }

        const i = this.#selected + 1;

        if (i >= this.#data.length) {
            this.#selected = null;
            if (this.#latest != null) {
                const tmp = this.#latest;
                this.#latest = null;
                return tmp;
            }
            return null;
        }

        this.#selected = i;
        return this.#data[i];
    }
}

const command_mode = Variable(false);
const command_out = Variable("");
const command_history = Variable(new History());
const search_history = Variable(new History());

function getHistory() {
    if (command_mode.value) {
        return command_history;
    } else {
        return search_history;
    }
}

const Launcher = ({
    width: screen_width = 2560,
    height: screen_height = 1440,
}) => {
    const apps = Widget.Box({
        vertical: true,
        spacing: 12,
        children: query("").map(AppButton),
    });

    const entry = Widget.Entry({
        hexpand: true,
        placeholder_text: "Search (`s` to focus; `!` for command)",
        class_name: "launcher_search",
        onAccept: (self) => {
            if (!self.text) return;

            self.text = self.text.trim();

            getHistory().value.insert(self.text);

            if (command_mode.value) {
                Utils.execAsync(`bash -c "${self.text.slice(1)}"`)
                    .then((output) => (command_out.value = output))
                    .catch((err) => (command_out.value = err));
                self.text = "!";
                self.grab_focus_without_selecting();
                self.set_position(1);
                return;
            }

            const results = apps.children.filter((item) => item.visible);

            if (results[0]) {
                App.closeWindow(WINDOW_NAME);
                results[0].attribute.app.launch();
            }
        },
        on_change: ({ text }) => {
            text = text ?? "";
            if (text[0] == "!") {
                command_mode.value = true;
                return;
            } else {
                command_mode.value = false;
            }

            apps.children.forEach((item) => {
                item.visible = item.attribute.app.match(text);
            });
        },
    })
        .keybind(["CONTROL"], "p", (self, _) => {
            self.text = self.text ?? "";
            self.text = getHistory().value.previous(self.text) ?? self.text;
            self.set_position(self.text.length);
        })
        .keybind(["CONTROL"], "n", (self, _) => {
            self.text = self.text ?? "";
            self.text = getHistory().value.next() ?? self.text;
            self.set_position(self.text.length);
        });

    const cli_text = Widget.Box({
        vertical: true,
        children: [
            Widget.Label({
                label: command_out.bind(),
                justification: "left",
                xalign: 0,
                wrap: true,
                useMarkup: true,
                css: "font-family: JetBrains Mono;",
            }),
        ],
    });

    const scroll_area = Widget.Scrollable({
        hscroll: "never",
        vscroll: "automatic",
        css: `min-height: ${screen_height / 2}px;min-width: ${screen_width / 3}px;`,
        child: Widget.Stack({
            children: {
                apps,
                cli: cli_text,
            },
            transition: "none",
            shown: command_mode.bind().as((val) => (val ? "cli" : "apps")),
        }),
    });

    return Widget.Box({
        vertical: true,
        className: "launcher_box",
        spacing: 12,
        children: [InfoPanel, entry, scroll_area],
        setup: (self) =>
            self
                .hook(App, (_, windowName, visible) => {
                    if (windowName !== WINDOW_NAME) return;

                    // when the applauncher shows up
                    if (visible) {
                        entry.text = "";
                        entry.grab_focus();
                    }
                })
                .keybind("s", () => entry.grab_focus()),
    });
};

export const LauncherWindow = Widget.Window({
    setup: (self) => self.keybind("Escape", () => App.closeWindow(WINDOW_NAME)),
    name: WINDOW_NAME,
    classNames: ["common_window"],
    child: Launcher({}),
    layer: "overlay",
    keymode: "on-demand",
    monitor: 0,
});
