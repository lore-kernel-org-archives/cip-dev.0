Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7134.1793697731719334751
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 01:22:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=HD3N/oaa;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dTfGKTEs;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1793697723; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BpZW9lpsmDYCAx+67FLGqpvNY/6tVxwHOz8oAhlANTas2qpKKsnoIGiSWva5x5+fFx
    1bUqDknaS8HTlOBXASrlEsUBL8+d1FNlvYe4ZrndH4M2S1AEb3hqG9+uNbRhUXcSBv4f
    zrDDMfzRtY9NLaLH9CVVufwEVE6e3N3GpRCGwMiENh5libnqhSgqCcis98/SQq3rIP1m
    vf4DyDlPnUTgWAYRioXg9dQJ8DNu9D3gYgu6PRu3BdY4LGPbmXLPwl2no/eMDAiZE1PA
    YA7RV2fdE1AKjUnvMlail82WRwXFuxKhLcJXlWeEDMQx4v4TxZFLfk+Wg5we6Dn3ndu4
    QrUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1793697723;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TeJ5uy8OgDehYQqfdsOiZIAK945vJoaq71e7mzL5/Bs=;
    b=lpd806U74j1eoV/9MdCY/WPZg3hVYrIrBt2VS49iiPG34dDh9LFKiXg9bOMrjCzQ1Z
    Xsk5V74s+nXgV365bVSKF6HDm1YuFDWKDCyPThd/IOwxV2/LU5jzCPrxUNuGtGHFb0ri
    myA9ROdTdVN0ev17BpO/Ry8EMpJDlaQXCtJIA2VCJI1hiYhGj8p49N6ENxhIUsimiOg8
    cGm9YfdVMOGxRWkhjl9+AX71qcrzV+teYf2wBY7aRFPutniSvBVnBv6crzqoumJFNn0s
    HBjJZrCfc6Im829/K/XJLzWWconS8RLyad5zCDCi+YcXtPkOhT+b6h1eqas4wBZxP93I
    SP5w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1793697723;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TeJ5uy8OgDehYQqfdsOiZIAK945vJoaq71e7mzL5/Bs=;
    b=HD3N/oaannfbYMyeF7dRtk3u0TLAkaxlga/8k7OCPFiR7h4c/qRx9EWsR+KaKv685+
    6fWBi84Np2JL9zcTEPuhQvvER8oB5sZpQp0w/XR9IO60Zp2zjhrfagYlGR10sbOUpfWJ
    mh8L+tjCDJERL/U3YfXincW3ue6MaT/zY9UljjmG13o22nrBepJySw8oeH/Bxsc+oinm
    WPkJKZ0dfNsvQB0vL7ICQk6jqp1aIMqBsxecP6hdJy67yy2aDc7OeGYjWtZ5Psg7+KJm
    Wh3Ji6b5zrvvOz3zVyQvoBbRdEw43f+uEzbOijW2LyqjjlGDHCYSvF0DL8r4luczYSOA
    9j1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1793697723;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=TeJ5uy8OgDehYQqfdsOiZIAK945vJoaq71e7mzL5/Bs=;
    b=dTfGKTEsbsgfYGNTtkNv1AmeLJVzn6qWH93Du4ixneNSOmvpbisW0Ms+Xq0MIFALpE
    ANEdbffJL6LpcACtskAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-19.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22A39M2QcU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 3 Nov 2026 10:22:02 +0100 (CET)
Date: Tue, 3 Nov 2026 10:22:02 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1099989158.146013.1793697722731@webmail.strato.de>
In-Reply-To: <auh1sRkdmg3AWRbt@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
 <auh1sRkdmg3AWRbt@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 38438
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 09:22:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24628


> On 11/02/2026 12:36 PM CET Pavel Machek <pavel@nabladev.com> wrote:
> These look ok to me:
> 
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thanks. Here's a last-minute addition:

09c9317a392321 ipv4: free inet_opt and ireq_opt after an RCU grace period

> > a91fd56ecf47a4 gpio: zynq: fix runtime PM leak on request error path
> 
> So this is common pattern and quite a common mistake. As it only
> happens in error paths, we may want to simply ignore this one.

ATM the triage rule "fixes a minor resource leak, for instance during initialization or deinitialization of a device" is listed under "backported at the maintainer's discretion" (which in practice means it goes in unless it looks like a regression risk to me). I guess I can move that to "must not be backported".

CU
Uli
