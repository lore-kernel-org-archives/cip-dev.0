From: kazuhiro3.hayashi@toshiba.co.jp (kazuhiro3.hayashi at toshiba.co.jp)
Date: Tue, 16 Apr 2019 13:22:00 +0000
Subject: [cip-dev] [cip-core] RFC: Process to decide supported package list
Message-ID: <OSBPR01MB277402D6349598D10F48A165E1240@OSBPR01MB2774.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello CIP developers,

I would like to suggest an idea about the process to determine the package list that should be supported by CIP.
It's difficult to discuss adding any packages including their dependencies from whole Debian, mixing the two profiles.

As the first step, it would be better to start from the source package list
which binary packages are installed by debootstrap minbase.
I attached the source package list, where only 58 packages exist.
I guess that it's easier to discuss which packages should be supported from such core components.

NOTE: busybox is not included in the attached list, but it have to be supported
not only for the tiny profile but also initramfs (and Debian installer?) in the generic profile.

Regarding the tiny profile, we need to keep discussion about which busybox applet should be supported.
I think this process should be done independently from the above discussion because
the all packages selected from debootstrap in the first step should be supported in the tiny profile as well.

Regarding voting, I have the same opinion that Daniel proposed previously.
	1. Send an initial list and vote (>50% means accepted)
	2. After that, each package will be voted (>50% means accepted)

As the second step, we consider adding other packages not included in the list one by one.
We need to decide the detailed process of the second step later.

If you have any other opinions, please let me know.

Kind regards,
Kazu

 Kazuhiro Hayashi
 Corporate Software Engineering & Technology Center
 Toshiba Corporation
 Tel: +81-44-549-2476
 E-mail: kazuhiro3.hayashi at toshiba.co.jp


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: srcpkg_buster_amd64_debootstrap_minbase.txt
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190416/51cbc671/attachment.txt>
