From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Sat, 15 Dec 2018 04:10:24 +0900
Subject: [cip-dev] Linux 4.4.166-cip29
Message-ID: <CAGDrK-YxePqVJLS+m3DnGZ1pQaa6aS33vhoA5JkKa+Py9NEKNA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, all.

I've released Linux version Linux 4.4.166-cip29.

https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/tag/?h=v4.4.166-cip29

The fix from Linux 4.4.154-cip 28 is as follows.

- Update dts of r8a77xx
  ARM: dts: r8a7743: Add PMU device node
  ARM: dts: r8a7745: Add PMU device node
  ARM: dts: r8a77(43|9[013]): Add missing OPP properties for CPUs
- Update to 4.4.166
- Change dts file name of socfpga DE0 sockit board
  ARM: dts: socfpga: Rename socfpga_cyclone5_de0_{sockit, nano_soc}

Best regards,
  Nobuhiro
