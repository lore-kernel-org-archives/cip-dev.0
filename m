From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 19 Apr 2018 10:32:55 +0100
Subject: [cip-dev] [PATCH 0/6] Fix R-Car I2C data byte sent twice issue
Message-ID: <1524130381-4346-1-git-send-email-fabrizio.castro@bp.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Ben,

a few weeks ago Zoran Stojsavljevic reported a problem with the RTC
on the iwg20d that turned out to be a problem with the I2C driver
sporadically sending data twice. This series backports the commits
from Wolfram that make up for the fix.

This series applies on top of v4.4.126-cip22.

Thanks,
Fabrizio

Wolfram Sang (6):
  i2c: rcar: make sure clocks are on when doing clock calculation
  i2c: rcar: rework hw init
  i2c: rcar: remove unused IOERROR state
  i2c: rcar: remove spinlock
  i2c: rcar: refactor setup of a msg
  i2c: rcar: init new messages in irq

 drivers/i2c/busses/i2c-rcar.c | 166 ++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 94 deletions(-)

-- 
2.7.4
