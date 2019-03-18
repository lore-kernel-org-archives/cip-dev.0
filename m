From: christian.storm@siemens.com (Christian Storm)
Date: Mon, 18 Mar 2019 09:42:18 +0100
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <375b3b16-8688-6fb2-4d4b-fc130c501c7e@siemens.com>
Message-ID: <20190318084218.jvf56lfecrbjtge3@MD1ZFJVC.ad001.siemens.net>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> > [Note] we are planning to develop the SWUpdate demo using ISAR, any
> > advice or news about how to build SWUpdate on ISAR with the right
> > U-Boot environment?
> > 
> > - Regarding SWUpdate we hit an issue that we had not expected
> > before. Suzuki-san was trying to update the standard BBB debian
> > image (or a yocto-made one), but there were many warnings about
> > orphan nodes etc. After some investigation the reason seems to be
> > that the rootfs is modified during the first boot (or something like
> > that). This is probably one of the biggest problems with updating
> > images instead of files.
> 
> Christian, any remarks?

Hm, did you check that you didn't flash the filesystem you have
currently booted, i.e., are you overwriting the currently running
root filesystem? I have seen such errors when I did this by accident.

Kind regards,
   Christian

-- 
Dr. Christian Storm
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M?nchen, Germany
