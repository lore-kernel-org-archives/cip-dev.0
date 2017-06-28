From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 28 Jun 2017 16:04:54 +0900
Subject: [cip-dev] Project-X (minimal root filesystem) for renesas board
Message-ID: <001001d2efdc$d8312a30$88937e90$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Koguchi-san,
Cc: Chris, cip-dev

I'm going to add support to project-X for the Renesas iwg20m board which is equipped with an armv7 chip.
I have noticed that you added support for beaglebone and cyclone on the deby-armv7 folder [1].

I have a few questions:
  - Why do you have two directories "linux-cip" and "linux-cip2" that are almost identical?
  - I can see some xserver-related definitions on the board's configuration file. Are those necessary?

Thanks,
Daniel

[1] https://gitlab.com/cip-playground/project-x/tree/master/deby-armv7
