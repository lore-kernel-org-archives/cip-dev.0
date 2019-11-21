From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 07:42:17 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 03/31] mmc: tmio: enhance illegal
 sequence handling
In-Reply-To: <CABMQnVJBd5BBpiONGpswAOrYg3s_zBLgRkm7DfHL7ejG87nUsw@mail.gmail.com>
References: <1574170570-15179-1-git-send-email-biju.das@bp.renesas.com>
 <1574170570-15179-4-git-send-email-biju.das@bp.renesas.com>
 <CABMQnVJBd5BBpiONGpswAOrYg3s_zBLgRkm7DfHL7ejG87nUsw@mail.gmail.com>
Message-ID: <OSBPR01MB2103E4E51D851CB7DCB0A1F0B84E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro-San,

Thanks for the feedback.

> Subject: Re: [cip-dev] [PATCH 4.4.y-cip 03/31] mmc: tmio: enhance illegal
> sequence handling
> 
> Hi Biju,
> 
> 2019?11?19?(?) 22:42 Biju Das <biju.das@bp.renesas.com>:
> >
> > From: Ai Kyuse <ai.kyuse.uw@renesas.com>
> >
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
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > [simon: broken out of a larger patch]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> >
> 
> Here is the addition of line breaks.

Can you please fix this while applying or do you want me to send another patch?

Regards,
Biju

> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >  drivers/mmc/host/tmio_mmc_pio.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> Best regards,
>   Nobuhiro
