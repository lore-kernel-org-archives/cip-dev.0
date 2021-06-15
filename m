Return-Path: <SRS0=g/0A=LJ=lists.cip-project.org=bounce+64572+6521+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AEAC48BDF
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 04:56:34 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4255E6109E
	for <cip-dev@archiver.kernel.org>; Tue, 15 Jun 2021 04:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4255E6109E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=abwesend.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6521+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yUeNYY4521723xxFCB3eU6m1; Mon, 14 Jun 2021 21:56:32 -0700
X-Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by mx.groups.io with SMTP id smtpd.web12.5313.1623732991451592255
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jun 2021 21:56:32 -0700
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
X-Received: from [165.225.200.148] ([165.225.200.148]) by web-mail.gmx.net
 (3c-app-gmx-bap33.server.lan [172.19.172.103]) (via HTTP); Tue, 15 Jun 2021
 06:56:29 +0200
MIME-Version: 1.0
Message-ID: <trinity-6d10b1dd-9c19-4367-a4cf-87791db11e4a-1623732989288@3c-app-gmx-bap33>
From: "Rainer Kloud" <rainer.kloud@abwesend.de>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] BUG: using smp_processor_id() in preemptible [00000000] code: TCPTSK/1809
Date: Tue, 15 Jun 2021 06:56:29 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <20210611223411.GA28449@amd>
References: <trinity-6c08d14f-96d0-4b01-b81c-dbc85783818e-1622901051584@3c-app-gmx-bs72>
 <20210606191433.GA18130@amd>
 <trinity-17b11b5f-9805-4527-89fb-1f3a0103a164-1623043418611@3c-app-gmx-bap15>
 <20210611223411.GA28449@amd>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:CeV/uhSVShUVFNILTQaAXMGE/4JnnVl3LIXEglVowuo3ODjOsTCByAmioIvdvVD+omtr4
 AcDQlxuW/meAMVcv6OCB0zx9MKAJNxyU8G04wKjuVYobe4IIVaEDlMAggjNIBZKb8qUa2ALSic8o
 JaoCelDi192yjn+c6fEzAFHr/XYjnwXnxBpzMe8AMkwAS3TZBJE4yf69EyTcybB9dALyXM6GXWnA
 SSn7T8C4DT1Z3fU6R4W6m5RjMgdnzEKYvoA4Kb+mdM5653s0EApqdd1fu0l37avYvJip+d3aeCkP
 Ns=
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZgAlqIYd3Ps=:mJw+mplTwn+FHu/w7PZWYL
 GrBhTRFWSuFso21eB9FHmopoXs6SS+zqY5NaS9spEj+7AMbyKEJlzmImJfbCMq+UiXp+DNTvR
 V6mdbX1KI1VZojj4OntdBntSQ7IQdoi5OWs4BICo1m3dPpRY69zXFuUPV+zL5voRNwPhaKkys
 yKzf/4dtEdoinq8y9004k5UOtSA0OGdxjH4YSmnQfNiXR3uHpHjQV69rLtaaESwFq9tMSBgMO
 xPO4qwlL6A9STS4AyjOpuqKhp04f+YUWk/mZdDgvJJIpOvQ6/rcbCbjBFQ9iZkkaV8IxEyw1p
 icd5111uq+M2H+Sln6O5niGAC1VhInbP6BJayIzA7YdbzD3xqz74PMhMwmd1V2Knb7P02Pb/V
 UPGHIPIMfDVl9KGjZGu2E7CeJ3aLpMGu6jKIIpCCvqJqXS3oM6HyM1lPVp95qG07AVJvBi21v
 Fb/YDUVvvKkSjy3dLb1dmYrm/VItV4zWRw5zt6OVSyVueNDUMyxkQIE3ocB4o0yDlQ+S7xEJF
 n1Eu+tDPCLGMFRtFkR28nA+CSBVea3OSJSOG1aFX3IuyF2ZW2ofwxLh2qHGWTlW9FhIwoFkgb
 nfzFlJj14MtO8hCPWvtng+d64+C5Q48y9kEV2JPROCBVTCUacOiYIXz7yPVeZGjg5sFQ1FQjU
 oyORp4QaTtzKOMyHNsV2W6y4w0HcQgH9iGlOeuT8U89NU4CvH3aNzCo2uhxvFhQLBbVUGou4D
 03wviF9YDgv8CD0SMmvdINxzRQKqSIrpXio4nLm315+Qtpp4DVBFQtWF85xlBAELJGyVz/cfo
 rAbnAuZAuApGmdETuaitqDv9L1ZYdCv9wc0aeHOU/FLKb+3Mx0=
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 6rKgZSdXxyzaXlnPL31JNkgcx4520388AA=
Content-Type: multipart/mixed; boundary="edUVVuG7GzTwhuvqU8pn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1623732992;
 bh=95bYhKTEgsWEYnPXHpYdBPgaEldQ94PUW9yS0o7a6G8=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=RpJMt1sb1PCcPD4W3aBC+8bhluLllmKU1ye65YhNhrosb1raFJmdALd88dMmKCZ++Il
 rYHa8E5v4t9IkhcAfBnaoxpmZ6GRZvQmT2bl1mz2qpZwVb/AC+7WtH96dPouj4oe1+MN+
 P2gtiEA0YjaKWXtI5V+OpCat2TW5JTnBqSo=

--edUVVuG7GzTwhuvqU8pn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

> > > I notice you are using -rt kernel. Do you actually need realtime
> > > features?
> >
> > Yes, I actually need the realtime feature. I have one task which
> > needs to run periodically in realtime (triggered every 10ms by an
> > external IRQ).
>
> How fast response do you need to the external IRQ?

We do not have "Hard-Realtime" requirements, but we should always handle t=
he IRQ inside of 1ms.

> > > Can you try to reproduce the problem on 4.19.193?
> >
> > This is only a problem with the realtime patch. The patch
> > introduces migrate_enable which is part of the callstack:
> >
> > Jun 1 09:11:46 sicam kernel: [46802.944165] BUG: using smp_processor_i=
d() in preemptible [00000000] code: TCPTSK/1809
> > Jun 1 09:11:46 sicam kernel: [46802.944210] caller is
> > migrate_enable+0x40/0x488
>
> Fun :-(. As Jan mentioned, testing if it can be reproduced with
> 4.19.193-rt81 would be useful.

Ok, I will give 4.19.193-rt81 a try.

Before we decided to switch to the 4.19.x kernel we tried in March this ye=
ar the 5.10.25 kernel with -rt35.
There we observed a very bad realtime behaviour. Our external interrupt ha=
d a latency of more then 4ms when our complete application was running. Th=
e IRQ task has realtime prio 51 and is therefore over all other IRQ tasks =
in the system (they have by default 50).
With kernel 4.19.x we do not see a latency over 1ms in the same configurat=
ion.

Best regards,
Rainer


--edUVVuG7GzTwhuvqU8pn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6521): https://lists.cip-project.org/g/cip-dev/message=
/6521
Mute This Topic: https://lists.cip-project.org/mt/83330337/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--edUVVuG7GzTwhuvqU8pn--
