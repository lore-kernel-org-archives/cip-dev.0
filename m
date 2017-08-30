From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 30 Aug 2017 21:05:57 +0200
Subject: [cip-dev] [PATCH 00/25] EXAR UART support for IOT2040 device
Message-ID: <cover.1504119982.git.jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Second chunk: This imports a number of preparatory patches in order to
fully exploit the PCI-attached dual-port EXAR with RS232/422/485 on the
IOT2040.

To avoid having to backport also API-changing patches for platform
devices, I've slightly modified two patches to use a communication
pattern that does not require these changes.

Jan

Axel Lin (1):
  gpio: exar: Set proper output level in exar_direction_output

Jan Kiszka (18):
  serial: 8250_pci: Use symbolic constants for EXAR's MPIO registers
  serial: exar: Fix mapping of port I/O resources
  serial: exar: Fix initialization of EXAR registers for ports > 0
  serial: exar: Fix feature control register constants
  serial: exar: Move Commtech adapters to 8250_exar as well
  serial: pci: Remove unused pci_boards entries
  serial: exar: Preconfigure xr17v35x MPIOs as output
  serial: exar: Leave MPIOs as output for Commtech adapters
  serial: uapi: Add support for bus termination
  gpio-exar/8250-exar: Fix passing in of parent PCI device
  gpio: exar: Allocate resources on behalf of the platform device
  gpio: exar: Fix reading of directions and values
  gpio-exar/8250-exar: Do not even instantiate a GPIO device for
    Commtech cards
  gpio: exar: Fix iomap request
  gpio-exar/8250-exar: Rearrange gpiochip parenthood
  serial: exar: Factor out platform hooks
  gpio-exar/8250-exar: Make set of exported GPIOs configurable
  serial: exar: Add support for IOT2040 device

Laxman Dewangan (1):
  gpio: Add devm_ apis for gpiochip_add_data and gpiochip_remove

Linus Walleij (1):
  gpio: add a data pointer to gpio_chip

Paul Gortmaker (1):
  serial: 8250_EXAR: fix duplicate Kconfig text and add missing help
    text

Sudip Mukherjee (3):
  serial: exar: split out the exar code from 8250_pci
  serial: 8250_pci: remove exar code
  gpio: exar: add gpio for exar cards

 drivers/gpio/Kconfig                    |   7 +
 drivers/gpio/Makefile                   |   1 +
 drivers/gpio/gpio-exar.c                | 196 ++++++++++
 drivers/gpio/gpiolib.c                  |  84 ++++-
 drivers/tty/serial/8250/8250_exar.c     | 636 ++++++++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c      | 484 +-----------------------
 drivers/tty/serial/8250/Kconfig         |   9 +
 drivers/tty/serial/8250/Makefile        |   1 +
 include/linux/gpio/driver.h             |  18 +-
 include/linux/platform_data/gpio-exar.h |  21 ++
 include/uapi/linux/serial.h             |   3 +
 include/uapi/linux/serial_reg.h         |   4 +-
 12 files changed, 977 insertions(+), 487 deletions(-)
 create mode 100644 drivers/gpio/gpio-exar.c
 create mode 100644 drivers/tty/serial/8250/8250_exar.c
 create mode 100644 include/linux/platform_data/gpio-exar.h

-- 
2.12.3
