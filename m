From: SZ.Lin@moxa.com (=?big5?B?U1ogTGluICiqTKRXtLwp?=)
Date: Thu, 3 May 2018 08:45:52 +0000
Subject: [cip-dev] Result of Kernel Patch Review - 4.4.129
Message-ID: <5942081F7727964D830FC876E62CA856014CC3913F@MHQMBX02.moxa.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

The following items in 4.4.129 are reviewed and mark as LGTM:

6f051f8986a8 writeback: safer lock nesting
4533f7e1785f watchdog: f71808e_wdt: Fix WD_EN register read
b7b4411c8990 clk: mvebu: armada-38x: add support for missing clocks
60f6c860c258 HID: core: Fix size as type u32
0ab6b8c91ecf usb: dwc3: pci: Properly cleanup resource
318a306c53d1 ARM: dts: at91: sama5d4: fix pinctrl compatible string
31118e88019f ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl property
e23007895028 usb: musb: gadget: misplaced out of bounds check
085c9c4b9e7e cdc_ether: flag the Cinterion AHS8 modem by gemalto as WWAN

SZ
