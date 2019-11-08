From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:17:44 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 37/83] mmc: tmio: enhance illegal
 sequence handling
In-Reply-To: <20191108093017.GH1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-38-git-send-email-biju.das@bp.renesas.com>
	<20191108093017.GH1017@amd>
Message-ID: <OSBPR01MB21035E103142DB13071AA15BB87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

HI Pavel,

> Subject: Re: [PATCH 4.4.y-cip 37/83] mmc: tmio: enhance illegal sequence
> handling
> 
> Hi!
> 
> > commit 96e0b2ba00ee5dacb12bed6585145ce784ec9153 upstream.
> >
> > An illegal sequence command error may occur if there is a stopbit or
> > cmd_index error as well as a CRC error. The correct course of action
> > is to re-enable IRQs
> >
> > An illegal sequence data error may occur if there is a CRC or stopbit
> > error,  or underrun. In this case set data->error correctly.
> >
> > This is in preparation for enabling tuning support which relies on
> > differentiating between illegal sequence and other errors.
> >
> 
> > @@ -609,8 +612,6 @@ static void tmio_mmc_cmd_irq(struct
> tmio_mmc_host *host,
> >  		goto out;
> >  	}
> >
> > -	host->cmd = NULL;
> > -
> >  	/* This controller is sicker than the PXA one. Not only do we need to
> >  	 * drop the top 8 bits of the first response word, we also need to
> >  	 * modify the order of the response for short response command
> 
> Is this removal intentional? I'm not sure from the changelog.

Yes, it is not clear from the changelog.

Regards,
Biju
