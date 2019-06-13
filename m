From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 13 Jun 2019 06:29:33 +0000
Subject: [cip-dev] [next] iwg20m: add support for this board
In-Reply-To: <16781a73-03dc-821b-4a4d-3cfda1636045@siemens.com>
References: <20190606074829.8104-1-daniel.sangorrin@toshiba.co.jp>
	<20190606074829.8104-2-daniel.sangorrin@toshiba.co.jp>
	<16781a73-03dc-821b-4a4d-3cfda1636045@siemens.com>
Message-ID: <TY2PR01MB3323EC8D5EF800010AE5D2E2D0EF0@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> > - Bmap notes
> >
> > The document doc/README_iwg20m.md uses bmaptool to
> > flash the image onto an SDCard. This functionality
> > is not yet available on the ISAR version used by
> > isar-cip-core. For now, you can either backport the
> > bmap patch [1] or use dd as explained in the README.
> >
> > [1] https://lists.cip-project.org/pipermail/cip-dev/2019-June/002430.html
> 
> We can add that patch to isar-cip-core until we update to a version that
> contains it -> follow-up patch.

OK, I added that and sent the patch to the list. I have also sent you a merge request on gitlab with the 3 patches.

Thanks,
Daniel
