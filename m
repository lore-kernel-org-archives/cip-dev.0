From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed,  5 Jun 2019 15:30:13 +0900
Subject: [cip-dev] Add bmap support for wic images in ISAR
Message-ID: <20190605063014.18193-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

There are methods to enlarge partitions on first boot, but if you prefer
to have an image of fixed size (e.g. 4GB) the bmap tool is quite useful.
It dramatically reduces the time required to flash your microSDCard.

This small patch adds that functionality to ISAR. Please consider it.

[ISAR] bmap: generate bmap for wic images

[Note] I created the patch on top of the isar used in CIP, if it doesn't
apply on latest branch please let me know.

Thanks,
Daniel
