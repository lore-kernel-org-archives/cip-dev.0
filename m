Return-Path: <wwd.smartmachine.stp@posteo.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C907C83F17
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 12:17:40 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web10.60614.1753964259324504147
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 05:17:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@posteo.org header.s=1984.ea087b header.b=GBS/+p8t;
 spf=pass (domain: posteo.org, ip: 185.67.36.66, mailfrom: wwd.smartmachine.stp@posteo.org)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 60C29240103
	for <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 14:17:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.org;
	s=1984.ea087b; t=1753964257;
	bh=X4jIQXBtNmIFNihWXx0xtUo9TbqO+f/oyiGHgDZKtk8=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=GBS/+p8tNn/3dFSHTHkJ9WPx3F92wJoffXnIH3GDWg0deHt3zziADYe2dBpt4lpPP
	 0FBbPshm7KEGiauBXvI+cOwc+Dmb92kHklVym/ViGI20hjb6npJim/JJnsbdOnqUrk
	 H6InSX9YtRVhQpMRzHLAFFIzWhCu5VehhpOX9PfGG8LnUs1ZSvJBnl16plz3tDpinp
	 2inApQFxKeFh7VDHAxImOAoQjmUIoebJq7dycPH2GwVyNPU4NGIIUjtwZ1p6hEINBj
	 elfz0li7mqG4bau0aqFsGp0BWrDi/2ZV5tSvD8CVRKZTKNO7YjBjuyexsoPd8PDo6/
	 UBid8+9lknKizXNxDhb1jCtWNK6k5sweit23FzqLd0kH1Z1S8rREOMGoDFTQPtJaYG
	 D3A614m51xWQwGSK06jjsbvQzS+MGmOzFpcrz2oz9J56a0Tfbofa6E2PddlSafprju
	 nlgTANYCtsYYPW4fTVCGLEumwPYbHEQAc5BHTvmI2GcEFAmdTss
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bt7Pr5gpZz6v1l
	for <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 14:17:36 +0200 (CEST)
To: cip-dev@lists.cip-project.org
From: Wolfram Wadepohl <wwd.smartmachine.stp@posteo.org>
Subject: CIP IEC 62443-4-x assessment
Message-ID: <f301b512-4775-429d-634a-e5fda909ca8a@posteo.org>
Date: Thu, 31 Jul 2025 12:17:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 12:17:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19648

Hi,
who may I contact about this topic?

-- 
Wolfram Wadepohl
Storopack Hans Reichenecker GmbH

