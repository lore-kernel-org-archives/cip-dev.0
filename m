Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B266C4332B
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:52:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1552076F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BE64B86F57;
	Thu, 19 Mar 2020 21:52:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qb1gk8qejW9f; Thu, 19 Mar 2020 21:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9C88086EFD;
	Thu, 19 Mar 2020 21:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8808DC07FF;
	Thu, 19 Mar 2020 21:52:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 737F8C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6063786EC1
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SdSWnqBzBt-1 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 21:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8959C86EB7
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:52:04 +0000 (UTC)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jF357-0001dD-Qx; Thu, 19 Mar 2020 21:52:02 +0000
Message-ID: <dc33d80bcae7830803faf5e41d9b83d7f23ea30a.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Pavel Machek <pavel@ucw.cz>, cip-dev@lists.cip-project.org
Date: Thu, 19 Mar 2020 21:52:00 +0000
In-Reply-To: <20200313210302.GA16410@duo.ucw.cz>
References: <20200313210302.GA16410@duo.ucw.cz>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: Re: [cip-dev] Backporting "net: ipv6_stub: use ip6_dst_lookup_flow
 instead of ip6_dst_lookup"
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

On Fri, 2020-03-13 at 22:03 +0100, Pavel Machek wrote:
> Hi!
> 
> Here's backport of `subj` to 4.19. ip6_dst_lookup_flow() prototype
> changed between 4.19 and mainline, files were moved around, and I
> could not find some instances to update. Fun!

I also had a go at this before catching up on cip-dev and finding you
had also done so.  So I've compared this with my version.

> I did minimal compile testing, I'll need to run it behind gitlab ci;
> but... if you are using IPv6 and can test this, it would be nice.

I haven't done real testing yet either.

> Best regards,
> 								Pavel
> 
> 
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 46b855a42884..e3c948617c73 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -415,9 +415,9 @@ static int addr6_resolve(struct sockaddr_in6 *src_in,
>  	fl6.saddr = src_in->sin6_addr;
>  	fl6.flowi6_oif = addr->bound_dev_if;
>  
> -	ret = ipv6_stub->ipv6_dst_lookup(addr->net, NULL, &dst, &fl6);
> -	if (ret < 0)
> -		return ret;
> +	dst = ipv6_stub->ipv6_dst_lookup_flow(addr->net, NULL, &fl6, NULL);
> +	if (IS_ERR(dst))
> +		return PTR_ERR(dst);

This leaves the ret variable unused, so I deleted it.

[...]
> diff --git a/include/net/ipv6.h b/include/net/ipv6.h
> index ff33f498c137..035cd7dc3836 100644
> --- a/include/net/ipv6.h
> +++ b/include/net/ipv6.h
> @@ -961,6 +961,13 @@ int ip6_dst_lookup(struct net *net, struct sock *sk, struct dst_entry **dst,
>  		   struct flowi6 *fl6);
>  struct dst_entry *ip6_dst_lookup_flow(const struct sock *sk, struct flowi6 *fl6,
>  				      const struct in6_addr *final_dst);
> +
> +static inline struct dst_entry *ip6_dst_lookup_flow_net(struct net *ign, const struct sock *sk, struct flowi6 *fl6,
> +				      const struct in6_addr *final_dst)
> +{
> +	return ip6_dst_lookup_flow(sk, fl6, final_dst);
> +}
> +

I think we should pick commit c4e85f73afb6 "net: ipv6: add net argument
to ip6_dst_lookup_flow" first instead of adding this adapter.  It is
explicitly described as preparation for this fix.

[...]
> --- a/net/tipc/udp_media.c
> +++ b/net/tipc/udp_media.c
> @@ -190,6 +190,14 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
>  			.saddr = src->ipv6,
>  			.flowi6_proto = IPPROTO_UDP
>  		};
> +		ndst = ipv6_stub->ipv6_dst_lookup_flow(net,
> +						       ub->ubsock->sk,
> +						       &fl6, NULL);
> +		if (IS_ERR(ndst)) {
> +			err = PTR_ERR(ndst);
> +			goto tx_error;
> +		}
> +		
>  		err = ipv6_stub->ipv6_dst_lookup(net, ub->ubsock->sk, &ndst,
>  						 &fl6);
>  		if (err)

You've not deleted the call to the old ipv6_dst_lookup operation here.

The mlx5_en driver *does* use the ipv6_dst_lookup operation in 4.19 so
it should be converted to ipv6_dst_lookup_flow.  The relevant code is
in drivers/net/ethernet/mellanox/mlx5/core/en_tc.c.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
