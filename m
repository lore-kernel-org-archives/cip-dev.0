Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB69C7114A
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 03:59:58 +0000 (UTC)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
 by mx.groups.io with SMTP id smtpd.web11.10393.1750132797359185922
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 20:59:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=yB1B7EiD;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.181, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af6a315b491so4772596a12.1
        for <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 20:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1750132797; x=1750737597; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZ1L2hnMTvP5CFnN541tlsCiPItB+W4qKIfSqDT8LW4=;
        b=yB1B7EiD8jIvU7COmZ457chafB59b626YusDbju3/329TpIGVKgk19KwgYkfJEPB96
         s/TZ9Yxc1H/F49Jc/9neJrKYpEJmVvMfb03a6oC1AzJpzeUqUGEd7irRYAzGssHC4tsn
         SKUPN6g6+mlAROKHWIAK4q4585dOLmpCFHlMlMH4CwUPbyt4RZFIGSZ3IB60YRsFhTU0
         ITIlHSM6eeQop3NLpyyVG/MTclD1Ik2w8fBOruB8KFcrOM7hN1S3Y67ml0dUe2qhxwPL
         jVhSaCN1ogYj/klkAcWafrNgNcSbYYiFqcIungyB6JvRKGlhFY9Bdx1nYI1vJNuX8vrO
         DwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750132797; x=1750737597;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZ1L2hnMTvP5CFnN541tlsCiPItB+W4qKIfSqDT8LW4=;
        b=hNFAv9KkSbBEXuzykWU0J/xfSm6ZLjqXuqje5pwpHX5dJRRZ+QhgCRb1t3Wmr2DBPG
         z+BQa6Npa4el6hCLbupzo6ra2jiJcVmbY4KREeCbG+V4IswFOuDfV7UjTP2cnCCDLAhf
         aftj9dfjeCXo+kR1CTuI96nd0I7cNUdLSpUa7RA9eSa4ekBLN3SQNOpaMJ1TQkD7oeO9
         NVGqBifeLkgdKXyGlH8vR3mKGk1n+XRlif/sHU87kkgurC2XgtZwaknL+w5gv+NLB1eg
         AyfyrdAVov90FOtvH3mq0MpA5cXGDdU+4fWQgFEUt/CWzoiRkuk9zI3F3z/LrbM1r+jl
         +Wsw==
X-Gm-Message-State: AOJu0YySCKjxVFB7wOKBPantAK6NLBB4JbnWjiVOP7Wp+O3tMmkCPStu
	EQi/+zpjPV6w6muDHPHKbrAjx8ZqMNGlD18x27+AQEhCvJQ4aD+mE9/AZ+UWCr+hSknDkmU5ND0
	24Mq/X+7OWgJdKjl9MVNsaLsbiKNSKN2VQGkZ94GWqS0Tk4kWaSal8A==
X-Gm-Gg: ASbGncuhymsP+Pemwa+rC4/RhbGPm3NeHbBSBCoNSd3IVOCLK0NiEdw7CPnIIvwtcTn
	tl1l63lyu3A+pgMhsRhO4jRkoiH6ZIczEelY3XNeE213O/Ug6gqepTJCmz3YI+PMZEc3cmWCIiI
	Ho7o9WHTdBEnmSMjiyA59XS3EkLYUmYeoQTIdx4q/A4a0=
X-Google-Smtp-Source: AGHT+IFB0bB4KWyixcIeK76930sSbWqTt83TKFMNRjajNH5xgZIA14dhgdOAJkIxvg87UFCgE83EnuY8+MdP7zBYkcI=
X-Received: by 2002:a05:6a21:8dcc:b0:21c:fc27:aee6 with SMTP id
 adf61e73a8af0-21fbd550d59mr17133520637.22.1750132796638; Mon, 16 Jun 2025
 20:59:56 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Tue, 17 Jun 2025 12:59:19 +0900
X-Gm-Features: AX0GCFue4PgE1M02lnQgRd8X2WPXpo1WOpOrPzYc8vfNJcK3PqvjPQAhtPRVgCA
Message-ID: <CANgtXuNeSW_Vs=5Hzw=c9=7DETu4bZET5shgeK0cpWp8bGdguQ@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 03:59:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19113

Hello

for personal reasons,
I will not attend this week IRC meeting.

Thanks,
Arisu

