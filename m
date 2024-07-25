Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F23BC3DA49
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 09:09:06 +0000 (UTC)
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
 by mx.groups.io with SMTP id smtpd.web11.32174.1721898543724006176
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Jul 2024 02:09:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IpKBhruR;
 spf=pass (domain: gmail.com, ip: 209.85.160.182, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-44feaa08040so1438031cf.2
        for <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721898542; x=1722503342; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elF18azTXUtE9ZojuHnf2VkwsaSkkfUzBXn6hQfVMwk=;
        b=IpKBhruR/lCB4Cd5MBcxQkC397S8rOz1k4gSrOYaHP3kU0WQZr64Rt3tXuiuVv02ZR
         1Zvxjw/i5cVFB6Cxn0B+EnvUYHKfShRrPNoGjtpAucxhIZ/tHo0jf5y7Vnw1Gx+sNHy4
         JQmaJ8mz7e7XaoGj/9PsKh/z6YG8lLfZWX4tTRrZlr7ZrllTTNPCqFqKC3wv7Y4awjWC
         3F6+QTWhg9RsCzPuvq3lDmtEkL6mzYK4DALTDhB77Dqs6T9hv8zYa5MAl43sz4M4xc3p
         sWQfk4Q2JZPam/tIEdMdqexHZCgq/tUQsdZ8VSvTa8lNDp4M1/7MlbBeJG2HCv5xaNoV
         LQTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721898542; x=1722503342;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elF18azTXUtE9ZojuHnf2VkwsaSkkfUzBXn6hQfVMwk=;
        b=PC9Q5/18sX8JvjYzLG+Kr5JJ7jVDP2+DBzbPmjGOfrNOAP3HaLPzIETE2IPBv5jYoD
         NI7EYYS+v2D93HpIGUT2Ixk8axYNWNMOnq+8QBxWxxsNRorNAGHcwCMj5PJnaclELJCt
         G3cVtfJP8DprkdytE9G4/J7xD7hES8XYCrmsxNORIVdxC5mxmC+SGJgQ5PWexKgSgddQ
         f76iCpFh5krytoCC00Cnsl7FXQnPKHCLqs+CdnKUDC5oBydk+VF22haIPEJLm78flsye
         FXwAOvPLKyROHGtsDNChIN7vN8dnRDLc7wORsOYaR6/PFPrHiLIS2bHopG2NfGRDdSFm
         Ht2A==
X-Gm-Message-State: AOJu0Yz5qvVhLrCPp6pKopq9pk5VSpgoAFpIWpujzHUNbn2kQHaUEA9u
	l2Sq/C3Gl7TJp2zVvRv/RnliH/S/hGDn2nIV27zRhfjryyNfKfydlSZV5vncnkA7hdV140rDPZ6
	avLAnz9K+t0nRCUvnODbCtpZFASNVzmRB
X-Google-Smtp-Source: AGHT+IEdeugejJnXN+YcLFa1bvhKpz5eAqH+3LyerwWslkbtWgodbZacuzBp26pml4fFs9l1XmasKX4YHGRIuWTYO90=
X-Received: by 2002:a05:622a:14d:b0:441:55be:bc66 with SMTP id
 d75a77b69052e-44fe929a750mr12356291cf.50.1721898542151; Thu, 25 Jul 2024
 02:09:02 -0700 (PDT)
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Date: Thu, 25 Jul 2024 18:08:51 +0900
Message-ID: <CACe6DC7A3BP5JmkGOH1WkoeitdDouept9eoV=MaQ3N=hHXd70Q@mail.gmail.com>
Subject: CIP IRC weekly meeting today / 20240725 on libera.chat
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Jul 2024 09:09:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16624

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2024&month=7&day=18&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     14:00     15:00     21:00     22:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2024/07/cip.2024-07-18-13.02.log.html

* Action items
  - prepare blog entry on SLTS kernel state and challenges [Jan]
* Kernel maintenance updates
* Kernel release status [*]
* Kernel testing
* AOB
  - alternates for next two meetings

Date the data is created: Thu Jul 25 09:08:33 AM UTC 2024
linux-4.4.y-cip: interval 30 day
  latest version release date: Mon Jul  8 09:35:34 AM UTC 2024
  limit date: Wed Aug  7 09:35:34 AM UTC 2024
  Status: On track
linux-4.4.y-cip-rt: interval 60 day
  latest version release date: Wed Jul 17 01:30:36 PM UTC 2024
  limit date: Sun Sep 15 01:30:36 PM UTC 2024
  Status: On track
linux-4.19.y-cip: interval 30 day
  latest version release date: Wed Jul 10 07:05:27 AM UTC 2024
  limit date: Fri Aug  9 07:05:27 AM UTC 2024
  Status: On track
linux-4.19.y-cip-rt: interval 60 day
  latest version release date: Fri Jul 12 03:18:17 PM UTC 2024
  limit date: Tue Sep 10 03:18:17 PM UTC 2024
  Status: On track
linux-5.10.y-cip: interval 30 day
  latest version release date: Wed Jul 10 04:51:56 AM UTC 2024
  limit date: Fri Aug  9 04:51:56 AM UTC 2024
  Status: On track
linux-5.10.y-cip-rt: interval 60 day
  latest version release date: Thu Jun  6 09:43:37 AM UTC 2024
  limit date: Mon Aug  5 09:43:37 AM UTC 2024
  Status: On track
linux-6.1.y-cip: interval 15 day
  latest version release date: Wed Jul 10 04:44:51 AM UTC 2024
  limit date: Thu Jul 25 04:44:51 AM UTC 2024
  Status: late
linux-6.1.y-cip-rt: interval 30 day
  latest version release date: Wed Jul 10 10:22:07 AM UTC 2024
  limit date: Fri Aug  9 10:22:07 AM UTC 2024
  Status: On track


Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu

