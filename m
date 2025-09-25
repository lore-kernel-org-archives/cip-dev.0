Return-Path: <pavel@denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AA6CAC5A5
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 11:35:38 +0000 (UTC)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 by mx.groups.io with SMTP id smtpd.web10.9228.1758800129397572254
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 04:35:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@denx.de header.s=mx-20241105 header.b=Bh+/qOys;
 spf=pass (domain: denx.de, ip: 89.58.32.78, mailfrom: pavel@denx.de)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B3E11038C109;
	Thu, 25 Sep 2025 13:35:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1758800127; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=3onoAbZjAiWgYgpDPVk41GEBSII2tIeWc3HApzkxvr0=;
	b=Bh+/qOysxEHL7cw4xjUZccxNOo7tjgnVyUpJ/KKYhB4pKQo5ltCLR/8SGeKXLJNc6LtcS3
	KnH9RVqv0m7G57Z3vnfJyJFNBMjTaUmP2jEfhDMGODfKAe0IkqghP6n8SAKO0SVDzvN+Au
	mA25Ml9crXMMdXO0vAGOa9dNZexlmNDh1adN//sx3IL0SM4xV8CrVs7XM0bjWu/N+UJD7G
	wA+n78Nycw4SrgyCWmH60aX5a9IQR0mJ+4VUKGnbQkEDSr1AGWrqhC0Y6UAt2PFPNAR3V5
	uemAP4xsWlcS8m0LbGJprB5vS9TA7p+YqyzFG0M7MmE63cApu+NwpCidWtX7kA==
Date: Thu, 25 Sep 2025 13:35:23 +0200
From: Pavel Machek <pavel@denx.de>
To: dinesh.kumar@toshiba-tsip.com, jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: Threat model documentation for kernel
Message-ID: <aNUo+0Mc3ez9ufD2@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cZyNKZOlpBi8XDpY"
Content-Disposition: inline
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 11:35:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20136


--cZyNKZOlpBi8XDpY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Below is start of threat model documentation for kernel. Did I miss
something significant?

Best regards,
								Pavel


Currently, CVE numbers are assigned for any bug that is fixed by -stable
-- that is not only for security-related bugs.

To make sure relevant security bugs are given suitable attention, it
would be good to define a threat model for our kernel. What is security
relevant differs according to use case, imagine for example:

Alice runs an NFS server on a ship, storing black box data. Server is
physically secured against unauthorized access, and only trusted
devices are connected to the local network, which is isolated from
the rest of the world.

Bob runs a web server on the public internet displaying weather. Server is
physically secured and only trusted users can connect over ssh.

Eve records video demos for youtube. You send her a binary over email,
she'll run it in her user account and record the screen using a camera.

Now, I'm pretty sure we want -cip kernel to be secure for Alice's use
case, and for Bob's use as well (provided he chooses reasonably secure
web server and his ssh password is not "123456"). I'm pretty sure -cip
Linux is not really suitable for Eve's use case.

Privilege escalation from local unprivileged user?

    $ ./tricky-code
    # id
    0

Resource exhaustion from local unprivileged user?

    $ _() { _ & _ }; _
    (hang)

DoS from local unprivileged user?

    $ cat /sys/foo/baz
    Kernel BUG ...
    Attempted to kill init, system halted

DoS from crafted filesystem.

    # mount /dev/usb0
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from crafted filesystem

    # mount /dev/usb0
    (shell appears listening on port 1337).

DoS from malicious USB device.

    (plug in USB device)
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from malicious USB device.

    (plug in USB device)
    (shell appears listening on port 1337).

DoS from malicious device.

    (CIA exploits firmware on Wi-Fi card).
    Kernel BUG ...
    Attempted to kill init, system halted

Code execution from malicious device.

    (CIA exploits firmware on Wi-Fi card).
    (shell appears listening on port 1337).

Privilege escalation from local privileged user?

    # insmod foo.ko
    Module signature failed, but module is loaded anyway

DoS from local privileged user?

    # echo foo > /sys/.../bar
    Kernel BUG ...
    Attempted to kill init, system halted

Remote code execution.

    $ echo xyzzy | nc target 1234
    $ nc target 1337
    # id
    0

DoS by crafted packets.

    $ echo xyzzy | nc target 1234
    $ telnet target
    target is not responding, still trying.

Are there any other threats that should be listed here?

I believe some threats are clearly in scope for us. Can we agree on
threats that are out of scope? Does it make sense to collect "which
company needs to care about which threats" list?

--=20
In cooperation with DENX Software Engineering GmbH, HRB 165235 Munich,
Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--cZyNKZOlpBi8XDpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCaNUo+wAKCRAw5/Bqldv6
8i5CAJ4jxhneqo2aRfYoc6wFyMYz/EOSRQCgvkVhbHXK02SxglLBQ8wUUlKCnao=
=lZnQ
-----END PGP SIGNATURE-----

--cZyNKZOlpBi8XDpY--

