Return-Path: <wwd.smartmachine.stp@posteo.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70307C87FD2
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 09:33:29 +0000 (UTC)
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
 by mx.groups.io with SMTP id smtpd.web11.57694.1753954408805117053
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 02:33:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@posteo.org header.s=1984.ea087b header.b=T7rgHMYP;
 spf=pass (domain: posteo.org, ip: 185.67.36.66, mailfrom: wwd.smartmachine.stp@posteo.org)
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 03993240101
	for <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 11:33:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.org;
	s=1984.ea087b; t=1753954407;
	bh=4Ltrs4NyEQDfDJSfnPR0OzA5tiXVhIwxiDgU6u2nRDU=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=T7rgHMYPmf1RyiZkEd5FqJkR4P+aQkQMAi1bkN+ctYxN99+/pz0S0ALr6/K/ypfDl
	 4XqrZiai4VUvOGdAuITBQqFWeh67Wr1BYRRywXmRn6qHSEDPIarATZrQmSqw7tZUvs
	 Qu6bgWKWGE8UpYr8aXwXFNCHfPItdYMQ6trreIxPwyn5GkHwZ9udvIyjraDDiEjFb2
	 v/p9yjzvHATR61aVArTuBMSbvO09AjWaMsnBFOo6sjSWmtG780ZjL2o3nOHq3vn6+s
	 Q2h0q0JpoWFlao6b51l9n6jxYyxcDEzRQLsTPY/W6VNfNg6/QnxwTmqJ8124mtVlb7
	 XgAP0Wcxltq3J+8K3F8kc6N/ZRhhPL003nBBUEULAzpAhYWbA15pr1Wg8zO5MTVIxp
	 AnCkT2Y2bySn7+9fh3FHx9iWdgshqp9tKNp0laSmqiNzFxa2y6MjqNFkAc6vEHhA8q
	 M2PYZqv3R/nviLpHuI8PFl3P6/CmweWnvgmf0OR60ZTlLzh+Fam
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4bt3mQ2kndz6txT
	for <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 11:33:26 +0200 (CEST)
To: cip-dev@lists.cip-project.org
From: Wolfram Wadepohl <wwd.smartmachine.stp@posteo.org>
Subject: RSS feed
Message-ID: <b702e481-d167-913c-90c0-5bf7de00eb47@posteo.org>
Date: Thu, 31 Jul 2025 09:33:26 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 09:33:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19639

Hi,
it seems that the RSS feed is disfunctional

-- 
Wolfram Wadepohl
Storopack Hans Reichenecker GmbH

