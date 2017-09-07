From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 7 Sep 2017 17:43:52 +0900
Subject: [cip-dev] Project-X: Deby-based reference filesystems milestone
	achieved
Message-ID: <001e01d327b5$6ec674e0$4c535ea0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi all,

I just added support in Project-X for the NE0-Nano-SoC Cyclone V board using the
CIP patched kernel provided by Koguchi-san (https://gitlab.com/cip-playground/linux-cip-cyclonev).
# Koguchi-san: thanks!

This completes the first milestone for Project-X, which added support for the Beaglebone Black,
Qemux86_64, Renesas iwg10m and NE0-Nano-SoC boards using Deby. All of them can be built with the
KAS tool (https://kas.readthedocs.io/en/latest/userguide.html) provided by Siemens 
(or alternatively with a setup.sh script).

https://gitlab.com/cip-playground/project-x

The next milestones are:
- to integrate them with B at D (I am currently working on the renesas board integration)
- to provide ISAR reference file systems (Jan: any plans about this? I can try but I have no experience with ISAR)

Thanks,
Daniel
