From: pavel@denx.de (Pavel Machek)
Date: Fri, 8 Nov 2019 12:37:23 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip 02/83] mmc: tmio_dma: remove debug
 messages with little information
In-Reply-To: <OSBPR01MB2103B4571650137144EC86B7B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-3-git-send-email-biju.das@bp.renesas.com>
	<20191108090732.GA1017@amd>
	<OSBPR01MB2103B4571650137144EC86B7B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <20191108113723.GR1017@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > >
> > > commit 254d1456560fa42d4ca901c9b9308e87c951fee1 upstream.
> > >
> > > When compiling the driver with CONFIG_MMC_DEBUG set, I got build
> > > warnings. They have been 'fixed' meanwhile. However, because these
> > > debug messages look random anyhow (some duplicate information printed
> > > etc), let's just drop them and rather re-add something consistent if
> > > that should ever be needed.
> > 
> > Its too late to change that now, but 1/ fixes messages and then 2/ just
> > deletes them. Single patch would do.
> 
> Are you ok to merge this patches while applying? or Do you want me to send another series fixing this?
> Please let me know.

I believe this is minor detail, and we can use the patches as-is.

See my reply to Chris for thoughts about rest of the series.

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
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191108/ebf3161b/attachment.sig>
