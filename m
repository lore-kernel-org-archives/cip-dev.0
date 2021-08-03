Return-Path: <SRS0=iXXx=M2=lists.cip-project.org=bounce+64572+6651+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520BC4338F
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 16:42:25 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE4E260555
	for <cip-dev@archiver.kernel.org>; Tue,  3 Aug 2021 16:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EE4E260555
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id MvqmYY4521723xX3dwPB8anR; Tue, 03 Aug 2021 09:42:24 -0700
X-Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web12.979.1628008941593840664
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Aug 2021 09:42:23 -0700
X-Received: by mail-ej1-f53.google.com with SMTP id nd39so37323889ejc.5
        for <cip-dev@lists.cip-project.org>; Tue, 03 Aug 2021 09:42:21 -0700 (PDT)
X-Gm-Message-State: cw7GO8nzwK00nHj0FfAcqHPOx4520388AA=
X-Google-Smtp-Source: ABdhPJw/qSc5ytX+g6Zt5kGVivxKGLrKIebCJmIm2vhX/A9YkKs/K4R1yi2QtZhFLgamGPC6wR+ieW6sGgmN/QxI7Wo=
X-Received: by 2002:a17:906:5fc7:: with SMTP id k7mr21067668ejv.377.1628008939884;
 Tue, 03 Aug 2021 09:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com> <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
From: "Alice Ferrazzi" <alice.ferrazzi@miraclelinux.com>
Date: Wed, 4 Aug 2021 01:41:43 +0900
Message-ID: <CANgtXuMoB2H+GmcugY6DAXTyZwEQ0-UHHOKyUbcAZMfKnipYHQ@mail.gmail.com>
Subject: Re: [cip-dev] FW: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, 
	"cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="D0LKvENTd3iFR6hZdKYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628008944;
 bh=BicqGG13IlDKz8gtBVDS4RVFGPX8NQ0+wfDYTW3nyWY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eHyziuMshymjeZMjWjc72Owo83lL0FCswChUcVPEBf6iTQHGnu1ppC/20ThNiUR1jr6
 7wLPDyqzI4qCuoyx8qns8vgWBFV3bHBnfLCHAGbW1bhCGil3VvVmYslQxGUTqAaFQRikF
 T3rHIJB9O6kYMDso8eU5h2QCEsgbiPcBHpU=

--D0LKvENTd3iFR6hZdKYC
Content-Type: text/plain; charset="UTF-8"

Hello,

On Tue, Aug 3, 2021 at 5:59 AM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello all,
>
> The KernelCI project has announced it's second hackfest in September.
> The first one was pretty successful in getting some new features added to KernelCI, and the hope is the same will happen next time as well.
>
> One hope from Alice and I is that we can get some CIP members involved to try and advance KernelCI + CIP integration/collaboration.
> If you have any time available during the hackfest and would like to get involved, please let me and/or Guillaume know.

Yes, I will be around during the hackfest helping out with KernelCI +
CIP integration tasks.

thanks,
Alice

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

--D0LKvENTd3iFR6hZdKYC
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6651): https://lists.cip-project.org/g/cip-dev/message=
/6651
Mute This Topic: https://lists.cip-project.org/mt/84623431/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--D0LKvENTd3iFR6hZdKYC--
