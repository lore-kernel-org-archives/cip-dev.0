From: pavel@denx.de (Pavel Machek)
Date: Wed, 17 Jul 2019 11:41:36 +0200
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] arm64: dts: renesas:
 r8a774c0-cat874: Add RWDT support
In-Reply-To: <OSBPR01MB2103A1E0EA93551375549E70B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1563200930-39297-1-git-send-email-biju.das@bp.renesas.com>
	<1563200930-39297-3-git-send-email-biju.das@bp.renesas.com>
	<20190716202735.GD9557@amd>
	<OSBPR01MB2103A1E0EA93551375549E70B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20190717094136.GB5105@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > cat874: Add RWDT support
> > 
> > On Mon 2019-07-15 15:28:46, Biju Das wrote:
> > > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >
> > > commit 79223ca1f57776d2770da9561c26cc2f2dd42205 upstream.
> > >
> > > Enable RWDT and use 60 seconds as default timeout.
> > 
> > So this will reboot machine if userspace does not ping it within 60 seconds by
> > default?
> 
> Yes,  if you enable watchdog  in user space and there is no ping activity for 60 sec.
> We can verify this by using the below  command

Aha. But if userspace does nothing, no reboot happens. Good.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/54762e4a/attachment.sig>
