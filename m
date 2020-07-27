Return-Path: <SRS0=uYXZ=BG=lists.cip-project.org=bounce+64572+5024+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=3.0 tests=BAYES_50,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720FAC433E0
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:36:00 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03ACB20714
	for <cip-dev@archiver.kernel.org>; Mon, 27 Jul 2020 12:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dw5M1ja7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03ACB20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5024+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZcCMYY4521723x7rEWN7wrGW; Mon, 27 Jul 2020 05:35:59 -0700
X-Received: from m68-68.mailgun.net (m68-68.mailgun.net [])
 by mx.groups.io with SMTP id smtpd.web12.54310.1595853260293817320
 for <cip-dev+int+1557+36663598960112671@lists.cip-project.org>;
 Mon, 27 Jul 2020 05:35:58 -0700
X-Mailgun-Sending-Ip: 166.78.68.68
X-Mailgun-Incoming: Yes
X-Envelope-From: <neal.caidin@gmail.com>
X-Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
 by mxa.mailgun.org with ESMTP id 5f1eca11.7fd2a2d06170-api-n20;
 Mon, 27 Jul 2020 12:35:29 -0000 (UTC)
X-Received: by mail-vk1-f175.google.com with SMTP id s192so3725319vkh.3
        for <dev@cip-project.org>; Mon, 27 Jul 2020 05:35:28 -0700 (PDT)
X-Gm-Message-State: L7NYTf6yl4CiscrJAChsG6qwx4520388AA=
X-Google-Smtp-Source: ABdhPJwiAIX3C2bjPB7GmoXaRHCHbPs+3IwlgbGPCNxrMXt/qNF+70XLIRFDd+FimyuLBIjlZ9r8wA9lfCK2gMMwYYY=
X-Received: by 2002:a1f:8d15:: with SMTP id p21mr1952666vkd.11.1595853327846;
 Mon, 27 Jul 2020 05:35:27 -0700 (PDT)
MIME-Version: 1.0
From: Neal Caidin <neal.caidin@gmail.com>
Date: Mon, 27 Jul 2020 08:35:17 -0400
Message-ID: <CAGZt0s46dnTgdg5BvCE74wm7CA9BDX+AJArXtA1oT760qKB3BQ@mail.gmail.com>
Subject: [cip-dev] Test - please ignore #email
To: Cipproject+Cip-Dev via Email Integration <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="QB2WKz7OkYF6JnDZDbsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595853359;
 bh=Mm5d0nolTphxrk1XIIDWzr0CPz/DsUsV17dGHB+KPiY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=dw5M1ja78cYvAmZNw+uWAm4phOyqh3JKD3thLKB9aKpHYNUVQEvb+5qdQB4D9RZtoKG
 60+KPjFPD9bShon6b80GXS1KDumAe0nXlMO2CYbwBOO4+MnQK4t9DvlorjA3YMdoJsaYW
 KWSK5cvRJ3DVciMOkOFnEBfMDLmYFWo2et8=

--QB2WKz7OkYF6JnDZDbsy
Content-Type: multipart/alternative; boundary="000000000000b850f805ab6b8ec1"

--000000000000b850f805ab6b8ec1
Content-Type: text/plain; charset="UTF-8"

Test - please ignore.

Thanks,
Neal Caidin
Linux Foundation

(sent from a personal account)

--000000000000b850f805ab6b8ec1
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">Test - please ignore.<div><br></div><div>Thanks,</div><div>Neal Caidin</div><div>Linux Foundation</div><div><br></div><div>(sent from a personal account)</div><div><br></div></div>

--000000000000b850f805ab6b8ec1--

--QB2WKz7OkYF6JnDZDbsy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5024): https://lists.cip-project.org/g/cip-dev/message=
/5024
Mute This Topic: https://lists.cip-project.org/mt/75821239/4520388
Mute #email: https://lists.cip-project.org/g/cipproject+cip-dev/mutehashta=
g/email
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--QB2WKz7OkYF6JnDZDbsy--
