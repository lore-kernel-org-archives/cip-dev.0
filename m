Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10553.1794480829646714722
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 02:53:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=CoHW4jbU;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=/BPj3rkM;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794480821; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=taBBVaNo9e5vq60dFoYmcNV0wAsQzwiCtTQNNwzqw0iLQjSGSQKSqOtPFB8/41OwLT
    d7cZXF+aQao7azhBeRruSMsvDk5UfHxPBenhKrbWiIdwgmJKH+tBPltmRdSF2Jepjab1
    MzFl8JbvBiB7cBuis/qb6CEmPKlbuPzCuGAmrth2Fm+W34yboW1poclznyyLm6bmlVxB
    U+i6v6z8n5dTzOTnPvx/z98P+xSXTExDMw/ruaKE95kLkD6ShBb8G+6yESCvq7pU+ZY8
    qPxnGtQQCRdrNQMy0H3UkcbsyMeaSfPasgeP13RUNBeUOqdeVfnrQX+IzNiZouEfyhzd
    h5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794480821;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y9C8a/U+FephvK2qN5wdrxXALkPEVPf6H5W4NQlaZvM=;
    b=iBCpYiT9Ldgab4Sc/os3GUIyd8UOvmwm1yb1TuqGUXtFg03ekfwZDcm3P32RYHNaFc
    PTwkRwNWjt9lxsuXpxsNhu1bmlHM1fqwtzMggDV/r0JEvbCja+is291/gRZK/CMkgl0R
    qdalO6oRMhhsvuSvY7KBjYV1lQUUiDZDxVte1sTB0Czy1bgtat823D5JVVxLBq/JoWf7
    3v5D3j6nU/dSz/q43rtt+tOnAckekYf0KPBWIoNBLzJBHz4tIgWL6FZXPMEOoWKr1QYW
    F69thMOp3eltEqAzYdvDnGZGjzdSGfUyAvyb000Q2aIt0rB6xf75juPjZOVRWG7jDmtw
    A0uQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794480821;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y9C8a/U+FephvK2qN5wdrxXALkPEVPf6H5W4NQlaZvM=;
    b=CoHW4jbU5C/ieC7rQzSFUKPNawMaSQ9WZjhtkX3ajuIBrdE+VFrUQ+GR5/z7fhmc7u
    Xy0noM0eDDaoL9P/i0O5gYt0ZWDVosPMgZpZj0cqOpVk+1Uh9sUeWHAAffDRW8lv+CT/
    qrBJwOH4/j6F1mj1RQqNqX3r9K6v3ir3SDoWgN/AeIwvqdyNJOtsmqBzqG5Ro/IF/us8
    tntE+97WnCCzNp7WKhghO8jPdiiKhjkoikSYILuEBIrx4sW7lSZyJDbiJR6bip5CfGqH
    +KCPzvv8hM23ODvnIa3YdhmNIeUTCacULZYZY2rC0eveFcRCFWPyMejuuCRUwcHuFixO
    XUYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794480821;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=y9C8a/U+FephvK2qN5wdrxXALkPEVPf6H5W4NQlaZvM=;
    b=/BPj3rkMxpw40tSI5CesGg/9KL/nnZ5davubNtdrSmD/xfwERzn5kbk3iMXZwKPv+w
    0gFwoaAnnGqG1BJTO/AA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22ACArf8mJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 12 Nov 2026 11:53:41 +0100 (CET)
Date: Thu, 12 Nov 2026 11:53:41 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1488484216.779551.1794480821558@webmail.strato.de>
In-Reply-To: <avOMN_cVRLv1uH9o@duo.ucw.cz>
References: <1931298540.80350.1793132613065@webmail.strato.de>
 <avOMN_cVRLv1uH9o@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st21, 4.19-cip137
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 38448
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 10:53:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24781


> On 11/10/2026 10:27 PM CET Pavel Machek <pavel@nabladev.com> wrote:
> I believe f6c6a70da060ea is a bit too complex for us.
> !! just a network namespacing, quite complex > f6c6a70da060ea rds: filter RDS_INFO_* getsockopt by caller's netns

Dropped.

CU
Uli
