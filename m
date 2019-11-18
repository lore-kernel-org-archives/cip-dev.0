From: pavel@denx.de (Pavel Machek)
Date: Mon, 18 Nov 2019 11:38:07 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 00/83] Add RZ/G1C SD/eMMC support
In-Reply-To: <OSBPR01MB2103F597589DEDA848C1246BB84D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <20191107210149.GA26444@amd>
 <TYAPR01MB2285DD15243063CDEA363B91B77B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191108113209.GQ1017@amd>
 <OSBPR01MB21039D7435442185F6280EADB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191108195823.GA23750@amd>
 <OSBPR01MB21032A76533C40F71367C4A4B8710@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191115123012.GA29996@duo.ucw.cz>
 <OSBPR01MB2103290FD10A0643F9A78824B8700@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <20191115211004.GA30273@duo.ucw.cz>
 <OSBPR01MB2103F597589DEDA848C1246BB84D0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20191118103807.GA7700@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > > > Yes please, if other maintainers are happy.
> > > > >
> > > > > Please apply the below patch patch before 33,
> > > > > https://patchwork.kernel.org/patch/11232167/
> > > >
> > > > I applied 1..33. That caused build failure. I added 35, which fixes
> > > > the compile problem.
> > >
> > > Yes. I knew, that is the reason I provided the above link.
> > 
> > Oops, I was not paying close enough attention. Sorry about that.
> 
> Is it possible for you to rearrange the patch?

> Ie, patch " mmc: add define for R1 response without CRC" should go before
> " mmc: tmio: add eMMC support". Other wise you will get a compilation error
> If someone checkout the branch with the commit id of  later patch.

It is possible, but it would require me to rebase and then force push,
causing problems for people who pulled the tree in the meantime. I
believe risks outweight the advantages at this point.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191118/efea7154/attachment.sig>
