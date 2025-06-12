Return-Path: <arisu.tachibana@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B548C71136
	for <webhook@archiver.kernel.org>; Thu, 12 Jun 2025 02:15:31 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
 by mx.groups.io with SMTP id smtpd.web11.3493.1749694522259418515
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Jun 2025 19:15:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=amHUHUiR;
 spf=pass (domain: miraclelinux.com, ip: 209.85.215.169, mailfrom: arisu.tachibana@miraclelinux.com)
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b26d7ddbfd7so393367a12.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Jun 2025 19:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1749694521; x=1750299321; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=amHUHUiRBqNjJv5wuheGaKSTttJb5XQzGRhLjcmGVW0bJksgO21BNprFpbLKeAHTD8
         aOsFQPsRl5wLH7wJjCQ5O5TWUqqY/nB8EfMEtwxpnaeuLvZZHGjHB3VNnbj/wLxJt+Ma
         LPrwvIDaJj8fuAs07BT+80apuoFHeA02cR1HxzzsYnUSzxOgXKTBkonfDYXI7ThoMcfy
         0J0unufqo4Xf/mbZcr3JoZRVC/HAnAtwr7KYg81PTGwf2jZYrPZ58wmArTGNIADQWZhe
         Rz7AdfPimzawJseopX/4nxI9swjNPxg896VoqrMfNLb4AqEdA/5+2Rm5WUBGMn2+69an
         B15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749694521; x=1750299321;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/owQvRID5HYH+toNSXIOwjjv0wE2Jc/jBp3GLwxB9Jw=;
        b=SSQ3gKjBYFaaRubqskYG3q0iV6wb36pOhRZLINmb3rGhomeQ7PBY0onJGjZXf1wLMw
         3AVLrwqUPXLQh6J8xwbSY4IKEWXPA6epvhX69r6tn5bE1ocB+fklOoWXUk9R20ZVUG1V
         OBihUoXS8HGL1oLEUg4imaQ1goT6lfgUGR7yqsCQNvefAMUJoYJLAndDqxu835kP2ClB
         wHqa5VQy++RPI3gvOfNq/2O79rRThvoTPgPyX1E6lZLlTlpwBVIv5C1zxllWZk8l3KcP
         awBtsb0fcau8GGELVc+0AVE1LqTRrQs2OkRbHoAzjpQ+vNLFuCoqjsEFPSCKFkDrLt5+
         X/NQ==
X-Gm-Message-State: AOJu0YzGulk5liG6+rKc0dSXPc3ZidobeL78gS5/22/mYarChFnjeVk9
	RAAObCLlUt7i9sH/zPRIpwp0A8pmMWOJ/IoLfQEVQMezzG/EVRtQltwL571F4J3oMRSXDPWGT9K
	5rSx9d6ntlcDOiEXQJ4kiK4GjqbbQcVoC1hC/3PJkqTQFeWPM2iVjDg==
X-Gm-Gg: ASbGnctsu4cgEkiZ/r+LQDv4CF7BkCs3iuHWYhyJZzAz+ZJMOxQ4JhR9f+lgfw7w4JW
	mlNv+95el1XaSUTJr1B8MlyFSLfFwhfcnPS0SpmcAsA8CDVxk9RqCWBUOWv6cBH4fTkDkGAn53V
	+BnkMq2950H6TJGHctBoVBuqBfXgeUWn7x/XrI2g7WZlQ=
X-Google-Smtp-Source: AGHT+IE09UnZ1L9T/wNqpCtYBJcBLPslKci2PJ6fTl6QUYXLK840VWlYF3LW+qmE/i+dkWslDYzcHRKH5gj3R0KkVD8=
X-Received: by 2002:a17:90b:3dc8:b0:312:db8f:9a09 with SMTP id
 98e67ed59e1d1-313af138589mr8665425a91.14.1749694521346; Wed, 11 Jun 2025
 19:15:21 -0700 (PDT)
MIME-Version: 1.0
From: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Date: Thu, 12 Jun 2025 11:14:45 +0900
X-Gm-Features: AX0GCFuVD0ZbLIj3TLpGC-rlYt3a_xI95EAlXysNdZgiIaQan0Si2ngxSPU5n80
Message-ID: <CANgtXuMcaHmMaZ6t-mC1Q-OYmM6tYcxeYKsMUshUuCweKDSoJw@mail.gmail.com>
Subject: IRC meeting
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Jun 2025 02:15:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19037

Hello

for personal reasons,
I will not attend today IRC meeting.

Thanks,
Arisu

