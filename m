Return-Path: <SRS0=RU50=4X=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB3C10DCE
	for <cip-dev@archiver.kernel.org>; Fri,  6 Mar 2020 08:21:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F30220848
	for <cip-dev@archiver.kernel.org>; Fri,  6 Mar 2020 08:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="prerTpmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F30220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D661A87475;
	Fri,  6 Mar 2020 08:21:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LDlmbgl60lTS; Fri,  6 Mar 2020 08:21:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E751286BE0;
	Fri,  6 Mar 2020 08:21:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB7B1C013E;
	Fri,  6 Mar 2020 08:21:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EBC4C013E
 for <cip-dev@lists.cip-project.org>; Fri,  6 Mar 2020 08:21:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 78FBF20380
 for <cip-dev@lists.cip-project.org>; Fri,  6 Mar 2020 08:21:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NSxypodeL+Y6 for <cip-dev@lists.cip-project.org>;
 Fri,  6 Mar 2020 08:21:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by silver.osuosl.org (Postfix) with ESMTPS id 7FB8C20242
 for <cip-dev@lists.cip-project.org>; Fri,  6 Mar 2020 08:21:39 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id a4so1103308qto.12
 for <cip-dev@lists.cip-project.org>; Fri, 06 Mar 2020 00:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=UNCJEdk/3/9gB2GYr2f+TGx1yThVLscfwj7O5mRYoo0=;
 b=prerTpmbsWJ3NZE+2qZa2Sv+YKTKOKaitOorxwaIuhkoRI3uOWkIhN+oUKxpVMJ88G
 FgsojdjGmUiYQvsR4G/cPEV0e/phhxwFMNmLaHh3qyZVCQ3Avp7A6xO6NnxRGoAyCWE0
 nInaUwV61TTXP3wvx/IZ+Ade14dvBrA15gmhwD5+Ku/XLzVd6aJDtMjKXglZAwzXwqWl
 KOWUpYam6DMNzHHYxQNNiPyLaNvKfpOtfE32Qp5dj76HC1UTCy2Rb4VoQ6GEj6/9gTaM
 FYUUms9Mi09CSGtggkbTxDN8wKDSVnG1yEJXQ3Aekcm/t2iwMBU8s6Nd5VKsb7nreocb
 OZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=UNCJEdk/3/9gB2GYr2f+TGx1yThVLscfwj7O5mRYoo0=;
 b=Pbon9e5UMhS3G+Hpytcn+gL+CTOkp5ovvA1X3XNOMTp81wAAbbJWJX3CVXuOrwV42f
 4dU5dRIva78tDs73H8tnyyZE5sPij1MzXO+yEI2rmw6TMyGTj4eD8HVuErF2SzKiJWo5
 KkcYChGKjCKcYfxoxtB+Kl3F9aKzUjfXGiKXniOQRjEEgxF0o9+bc9u50e7Jl3Mg+QwG
 SJNKzDImuMsGWKPZI/DuS2X5ufC5gHyW4WfaZ8vYcWKCireqHMQMrF2Tg7VzQLJMHk71
 gkZvqTybiYAk1855zGfxbKEQ6weyug4nu4FfjXZfewwRW6Q0mVfWPNG9Qsg04M03NXuA
 Mf2g==
X-Gm-Message-State: ANhLgQ0RiqHSYVSBxmtgkqUx0QjEVQ5OOBWZwuu1BZA6QoY8Rqxbtj8j
 NM+hxi9l2prQThchq+4FSOas95dmRA6xuG4GYCH7bhtN5Io=
X-Google-Smtp-Source: ADFU+vsYA1unzv3mLcPic+kQyARctFs33JQM+zk4jwMPzaB9jO1DRVWIIn0zT3mD8lfNKpQ3eXNJDBZHcwh8d/2Y4kE=
X-Received: by 2002:ac8:3671:: with SMTP id n46mr1945525qtb.33.1583482898268; 
 Fri, 06 Mar 2020 00:21:38 -0800 (PST)
MIME-Version: 1.0
From: vijai kumar <vijaikumar.kanagarajan@gmail.com>
Date: Fri, 6 Mar 2020 13:51:27 +0530
Message-ID: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
To: cip-dev@lists.cip-project.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [cip-dev] Linux-cip: Kselftest plans
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

Hi All,

Is kselftest maintained in the cip-kernel tree? I do see some
branch[1] maintained by Nobuhiro-san for kselftest, but it's out of
5.6 linux tree.

The reason being to gather collective thoughts about the plan for
kselftest based tests for cip kernel. Are there any existing or future
plans for using kselftest for testing cip kernels? If so are we going
to use the latest tree from upstream or plan to fix/backport test
cases to current cip kernel versions?

[1] https://gitlab.com/cip-project/cip-kernel/linux-cip/-/tree/ci/iwamatsu/linux-cip-kselftest

Thanks,
Vijai Kumar K
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
