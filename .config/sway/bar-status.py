#!/bin/env python
from datetime import datetime, timedelta
import json
import asyncio
import enum


class NotificationState(enum.Enum):
    NORMAL = ""  # 󰂚
    UNREAD = "󱅫"
    DND = "󰂛"


class Status:
    def __init__(self) -> None:
        self.notif: NotificationState = NotificationState.NORMAL
        self.datetime: datetime = datetime.now()

    async def update_datetime(self) -> None:
        """Updates the datetime by waiting for next second to arrive."""
        while True:
            now = datetime.now()
            next_second = (now + timedelta(seconds=1)).replace(microsecond=0)
            time_to_next = (next_second - now).total_seconds()
            await asyncio.sleep(time_to_next)
            self.datetime = next_second
            self.print()

    async def update_notif(self) -> None:
        """Updates the notification update when updates are received from `swaync-client`."""
        process = await asyncio.create_subprocess_exec(
            "swaync-client",
            "-s",
            stdout=asyncio.subprocess.PIPE,
        )

        assert process.stdout is not None
        async for line in process.stdout:
            state = json.loads(line)
            if state["dnd"] is True:
                self.notif = NotificationState.DND
            elif state["count"] > 0:
                self.notif = NotificationState.UNREAD
            else:
                self.notif = NotificationState.NORMAL
            self.print()

    def __str__(self) -> str:
        elements = [
            self.notif.value,
            self.datetime.strftime("%a %Y-%m-%d %H:%M:%S"),
        ]
        return " ".join(elements)

    def print(self) -> None:
        print(self, flush=True)

    async def run(self) -> None:
        async with asyncio.TaskGroup() as tg:
            tg.create_task(self.update_notif())
            tg.create_task(self.update_datetime())


def main() -> None:
    status = Status()
    asyncio.run(status.run())


if __name__ == "__main__":
    main()
