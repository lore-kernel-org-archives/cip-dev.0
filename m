From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Wed, 5 Jun 2019 08:35:55 +0200
Subject: [cip-dev] Add bmap support for wic images in ISAR
In-Reply-To: <20190605063014.18193-1-daniel.sangorrin@toshiba.co.jp>
References: <20190605063014.18193-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <7f7d46c8-1ddb-1516-cc43-a12ed2e760e3@siemens.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On 05.06.19 08:30, Daniel Sangorrin wrote:
> Hi,
> 
> There are methods to enlarge partitions on first boot, but if you prefer
> to have an image of fixed size (e.g. 4GB) the bmap tool is quite useful.
> It dramatically reduces the time required to flash your microSDCard.

There is indeed a concrete use case for that: swupdate images where you need to 
set static sizes for the updatable partitions. Probably worth mentioning.

> 
> This small patch adds that functionality to ISAR. Please consider it.
> 
> [ISAR] bmap: generate bmap for wic images
> 
> [Note] I created the patch on top of the isar used in CIP, if it doesn't
> apply on latest branch please let me know.

Always base on next. We can update downstream once it's merged here or carry a 
backport there. So, please rebase.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
