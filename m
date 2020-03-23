Return-Path: <SRS0=7RAa=5I=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A9C3F2CD
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 16:54:47 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68C5C206C3
	for <cip-dev@archiver.kernel.org>; Mon, 23 Mar 2020 16:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEeFhvhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C5C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2921188311;
	Mon, 23 Mar 2020 16:54:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lSKzsDJVv9P9; Mon, 23 Mar 2020 16:54:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B7570882A1;
	Mon, 23 Mar 2020 16:54:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A04AEC0177;
	Mon, 23 Mar 2020 16:54:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4DC3C0177
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 16:54:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A3CD32155D
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 16:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4rryiV9AAFhv for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2020 16:54:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by silver.osuosl.org (Postfix) with ESMTPS id EED01203BE
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 16:54:44 +0000 (UTC)
Received: by mail-qk1-f170.google.com with SMTP id v7so6422204qkc.0
 for <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2020 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=I4BIThcc+4nFLJ49/H0sNGB7InW2LUZxFyiF9rDa89s=;
 b=SEeFhvhOuD39/JYmJ2FiAz5lkEhrd1YpRCTzQslW6l8tY6uOSQbYcdbUTHYU6IwvzH
 d3O0VZsRuIccRhapD78p9AtYm/XTFfvJjYQrH7/AXVrXnOgPMOU4pRZFw0B/HaAZvVvC
 XMLGl0qZx7/7J4hf088rerTUdtc47/MVbk4JZFwSkrba+9WlH0eS1lTC+gUT+mVbeyS1
 L+0IIkwt0ObGrw0TY9oc9s4vrvlllOBCpde7F1bmeNJQJnr5VGp1396oGes1fHIQ110z
 VEMLB/10dUtAd37TtX4w9f8CWPNGFsb9UF7k7EG02GNZOlBbuVB32OQ3P/nwvg0nePMk
 UIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=I4BIThcc+4nFLJ49/H0sNGB7InW2LUZxFyiF9rDa89s=;
 b=PQXhUMIBH/Uisn7UWfq/BwPrGHRbJd1S/dL6f8FisaL9ohA3tLeRRAk7l/WoCNbhhe
 THTGLjtPoMGT4RC6ojBA9jwjQSz8bCTZmyee6OgN68gQN7VubhyYaBlyyzhNRlKwltbW
 qmQZdBVbDaJhIlxcZtTS7GqexKvgZASYiGhOSa6TApltI4IPeQi79+TOOE1EoiGyQiBp
 3RLzLs2ZXrdtE2FqIErkCthRBWcZTqncedoWC3c+yjSrboU+MY2hsAb3m8lSfWFhVSol
 ajgUVhCRKhUYvpegQ5uLWjmVKgC7KQUtb4oKXxbBLgvJY8DRGwJI21YW8YQOKlXyN3QC
 4Zeg==
X-Gm-Message-State: ANhLgQ0qrnwjxKWqhdQ4APg5a31Xmzw7QpLD37f03Z/V1qC6APupg2t5
 pRBxUCuVpp3b7TN1vchYA7gKrzD5Xgztoo8+Q3VLLSF6
X-Google-Smtp-Source: ADFU+vvGOzjRMvVTEZ8YtZ3o+G14jlyZ2Mo/cALG5nk6fBeZjIuIDF4w3iBuEBknLd2ta9pR58ua3bFiunX5jiJlKFQ=
X-Received: by 2002:a37:8d86:: with SMTP id p128mr3258687qkd.250.1584982483494; 
 Mon, 23 Mar 2020 09:54:43 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Andreas_Wei=C3=9Fel?= <andreas.weissel@gmail.com>
Date: Mon, 23 Mar 2020 17:54:32 +0100
Message-ID: <CAC4QREfMtM1MQBVf2ZhRbBstUkCBbny5pwWEd_dJ09GcQpyiHA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] Super long-term kernel support
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

Hi CIP kernel team,

I have a question regarding the super long-term kernel support: can
other commercial or non-commercial projects make use of such kernel
versions like "linux-4.19.y-cip", i.e., use the CIP git repositories
to address security issues (CVEs) in the Linux kernel even after the
upstream long-term versions are no longer supported, or is this
considered a service for members only?

Regards
Andreas Weissel
_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
