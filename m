Return-Path: <SRS0=3drx=5F=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5483EC4332D
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 21:41:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B7420767
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 21:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DB0038928D;
	Fri, 20 Mar 2020 21:41:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gzLMhtiP5ntV; Fri, 20 Mar 2020 21:41:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C4AD387F8E;
	Fri, 20 Mar 2020 21:41:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8BE5C07FF;
	Fri, 20 Mar 2020 21:41:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1AF5DC07FF
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:41:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0987285E35
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:41:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QiaIfotAkN-3 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2020 21:41:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 33CDE86C78
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:41:13 +0000 (UTC)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jFPO9-0004MK-1z; Fri, 20 Mar 2020 21:41:09 +0000
Message-ID: <5f17418f68274169e0e08af7b02529912358dc54.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Pavel Machek <pavel@ucw.cz>, cip-dev@lists.cip-project.org, 
 Chris.Paterson2@renesas.com
Date: Fri, 20 Mar 2020 21:41:08 +0000
In-Reply-To: <20200215195407.GA10344@amd>
References: <20200215195407.GA10344@amd>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: Re: [cip-dev] [backport 4.4] mac80211: Fix TKIP replay protection
 immediately after key setup
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

On Sat, 2020-02-15 at 20:54 +0100, Pavel Machek wrote:
> Hi!
> 
> So... this is first backport patch. I'll need to reformat a changelog.
> 
> The patch should pass our tests on gitlab, but I somehow don't think
> those tests involved wifi at all... At least it compiles.
> 
> Can someone test it easily? Should I just submit it to stable
> explaining I did not test it?

That's what I would do.

> Do you have other patches that should go to 4.4/4.19?
> 
> Best regards,
> 								Pavel
> 
> commit 911e21ed055f6700fa80d0f7a818ba223999bb2a
> Author: Pavel Machek <pavel@ucw.cz>
> Date:   Thu Feb 13 22:56:46 2020 +0100
> 
>     Author: Jouni Malinen <j@w1.fi>
>     Date:   Tue Jan 7 17:35:45 2020 +0200
>
>     commit fa73f24d1b119b85b32cd8f217a73d108888097e

This reference is wrong; the upstream commit is
6f601265215a421f425ba3a4850a35861d024643.  Also the usual format for
this reference has "upstream." after the commit hash.

[...]
> --- a/net/mac80211/tkip.c
> +++ b/net/mac80211/tkip.c
> @@ -265,10 +265,21 @@ int ieee80211_tkip_decrypt_data(struct crypto_cipher *tfm,
>  	if ((keyid >> 6) != key->conf.keyidx)
>  		return TKIP_DECRYPT_INVALID_KEYIDX;
>  
> -	if (key->u.tkip.rx[queue].state != TKIP_STATE_NOT_INIT &&
> -	    (iv32 < key->u.tkip.rx[queue].iv32 ||
> -	     (iv32 == key->u.tkip.rx[queue].iv32 &&
> -	      iv16 <= key->u.tkip.rx[queue].iv16)))
> +	/* Reject replays if the received TSC is smaller than or equal to the
> +	 * last received value in a valid message, but with an exception for
> +	 * the case where a new key has been set and no valid frame using that
> +	 * key has yet received and the local RSC was initialized to 0. This
> +	 * exception allows the very first frame sent by the transmitter to be
> +	 * accepted even if that transmitter were to use TSC 0 (IEEE 802.11
> +	 * described TSC to be initialized to 1 whenever a new key is taken into
> +	 * use).
> +	 */
> +	if (iv32 < key->u.tkip.rx[queue].iv32 ||
> +	    (iv32 == key->u.tkip.rx[queue].iv32 &&
> +	     (iv16 < key->u.tkip.rx[queue].iv16 ||
> +	      (iv16 == key->u.tkip.rx[queue].iv16 &&
> +	       (key->u.tkip.rx[queue].iv32 || key->u.tkip.rx[queue].iv16 ||
> +		key->u.tkip.rx[queue].state != TKIP_STATE_NOT_INIT)))))
>  		return TKIP_DECRYPT_REPLAY;
>  
>  	if (only_iv) {

This backport makes sense to me.  Please can you send it to the stable
list, with the fixed commit message?

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
