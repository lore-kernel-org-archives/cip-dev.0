Return-Path: <alice.ferrazzi@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8026C433F5
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 04:33:19 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.29116.1640233998330412815
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 20:33:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=V6kHi8uf;
 spf=pass (domain: miraclelinux.com, ip: 209.85.208.44,
 mailfrom: alice.ferrazzi@miraclelinux.com)
Received: by mail-ed1-f44.google.com with SMTP id f5so16544203edq.6
        for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 20:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=qw+Q/BVJI1UFSQpOANUXFgjT7+CcQ/5Wlusq/unPiXI=;
        b=V6kHi8ufBDLPQp4BmXc0GtfOCcu9ukVmDEmMm5muEwW75DuxDQQrEjGt77DC5q+BBr
         qENZ0Bepjza+cgstz7WSR3wEAWSuzhnuOs3TMsqJDQIMCc3kRB3mdkA1qR6/zNQc/Sdj
         g8AXFsEt2rokfn2EDL9vVTEfk8eqIqGA2OpIc931sKqezNjHHDRJamoWYjXkJdBBCAD4
         uLjo3Cvg15jtaiyZ/FoZ1cTlC1Exjhx9mEep6YGhJy3T0oH3a3TyyEJwfYqijlbE0ua3
         y2O1Ud+q3jPQXM1/tiQbc+9MqxxY7bMS2P3yTC9BNSRzAtdbV95ddm4OpWjY76A/45Wr
         pIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qw+Q/BVJI1UFSQpOANUXFgjT7+CcQ/5Wlusq/unPiXI=;
        b=sLnfiCUw2QapYuozJ7PdSUCC608XXrZqHsBXSNMfeAWa9mY36NJi2mleI4O3hTcG4P
         2NafR67VBkqkSXbYyEtHeTgcMQ5J0R6GLbFbULkcPBZGqYJ0WgMvy28zv6kOj1FrId4e
         okuzXCdgnpSnK0dOw1PI6lvfOOZELCyqecAUIvKZ7DYfX4XG3S9MHzwrVq+uF9VYKV6+
         vNNHwlY4SxKPkw1h9vK7vQyJ9VvAek9CeCqzY/0iXwYy+xPGkdaaqupOxLmV8Vdi1Ig5
         x/Q5shPPmRyoaEBYvNFP427Uc5SzTJSTkyO9rIkVRLn4G60xzmrYkBqC8WmyfvE7CKS/
         NTNQ==
X-Gm-Message-State: AOAM531/27hti1kBpCm1JcKyU/Xb+Zok2whWkNrlwrk6JJ4AEwsO5V6S
	VBTwLQey9oxsplFl94MSCl+NZc8nqn8JHpgb9lcrNpVY+s3l
X-Google-Smtp-Source: 
 ABdhPJxL7KKt6gADkbuT+X3wwdge9LP71xwXvIIf8xzVvVg0gSEfpwBbC5rXqOws9Fy+Qood2QCBWx/Ksm1vEs7czgw=
X-Received: by 2002:a17:907:94ce:: with SMTP id
 dn14mr583817ejc.85.1640233996254;
 Wed, 22 Dec 2021 20:33:16 -0800 (PST)
MIME-Version: 1.0
From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Date: Thu, 23 Dec 2021 13:30:18 +0900
Message-ID: 
 <CANgtXuPRnHck86sFxMuFG=W5e1xJMm-90XpkH-pxBQf72qM=Yw@mail.gmail.com>
Subject: [cip-dev] CIP IRC weekly meeting today on libera.chat External
To: cip-dev@lists.cip-project.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Dec 2021 04:33:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7261

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 13:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2021&month=12&day=23&hour=13&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
06:00     09:00     13:00     14:00     21:00     22:00

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/12/cip.2021-12-16-13.00.log.html


* Action item
  1. Combine root filesystem with kselftest binary (finishing) - alicef
  2. Propose tweet on KernelCI-CIP collaboration progress - alicef
  3. Clarify with KernelCI whether CIP maintainers can get accounts - alicef
* Kernel maintenance updates
* Kernel testing
* AOB


Thanks,
Alicef

-- 
======================================
Cybertrust Japan Co.,Ltd.
Alice Ferrazzi
alice.ferrazzi@miraclelinux.com
======================================

