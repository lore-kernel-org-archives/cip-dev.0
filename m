From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:28:00 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 63/83] mmc: tmio: always get number
	of taps
In-Reply-To: <20191108094434.GL1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-64-git-send-email-biju.das@bp.renesas.com>
	<20191108094434.GL1017@amd>
Message-ID: <OSBPR01MB2103E396605C0134CB190205B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org


Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 63/83] mmc: tmio: always get number of taps
> 
> Hi!
> 
> > commit 43b0b361b0170030603cf76f70b099f3323edcf3 upstream.
> >
> > Current code gets number of taps only once and keeps the value. This
> > is not correct, we need to obtain it every time before executing
> > tuning, so remove the outer if-block.
> 
> I'd somehow assume number of tuning parameters would be fixed... Does
> the hardware really change it? Out of curiosity, why is it doing so?

I guess it is for hs200 and hs400 tuning.

Regds,
Biju
