From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 09:15:40 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 02/83] mmc: tmio_dma: remove debug
 messages with little information
In-Reply-To: <20191108090732.GA1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-3-git-send-email-biju.das@bp.renesas.com>
	<20191108090732.GA1017@amd>
Message-ID: <OSBPR01MB2103B4571650137144EC86B7B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Friday, November 8, 2019 9:08 AM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.4.y-cip 02/83] mmc: tmio_dma: remove debug
> messages with little information
> 
> Hi!
> 
> > From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> >
> > commit 254d1456560fa42d4ca901c9b9308e87c951fee1 upstream.
> >
> > When compiling the driver with CONFIG_MMC_DEBUG set, I got build
> > warnings. They have been 'fixed' meanwhile. However, because these
> > debug messages look random anyhow (some duplicate information printed
> > etc), let's just drop them and rather re-add something consistent if
> > that should ever be needed.
> 
> Its too late to change that now, but 1/ fixes messages and then 2/ just
> deletes them. Single patch would do.

Are you ok to merge this patches while applying? or Do you want me to send another series fixing this?
Please let me know.

Regards,
Biju
