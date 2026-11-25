Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43989.1795619960276817051
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 07:19:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@kernel.org header.s=k20260515 header.b=iB0RPjE+;
 spf=pass (domain: kernel.org, ip: 172.234.252.31, mailfrom: harry@kernel.org)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 80B6843639;
	Wed, 25 Nov 2026 15:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61781F000CA;
	Wed, 25 Nov 2026 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619587;
	bh=grCglpvS1lmgRAOWz2fgR+PrAXF3N9/tLLxd6ICUxy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iB0RPjE++rgwjZ78MftirKMEilvmJDSVplUkjMjsFliZsNlVhz6LHbMtmfxYfW/Nj
	 F2kcGN3/AuXODAtuxNeGHGbdpk+63bx44lMEcnrQNBIKjqpf6iSzOl1YqdnVUEGetn
	 OKiqemMdcV7N4q8ABQ0nDKD79HzpSNSW9fOsBTNectISbm/KEHpcSl1czMhDqGCoJS
	 X+CupyitUx2Bnea12XiUCZbF2o0D650hluaLFO2B/OPwUsgi85tLRbLy6/px3fo4Id
	 HuRQ9/IqTVAaYq1e6Y9lQCnayy6qWKMjYSDk2p5GA2nqdjVMfOp4ExBIn4kJfauyN5
	 a9HmxBEOgmsmQ==
Date: Wed, 25 Nov 2026 15:13:05 +0000
From: Harry Yoo <harry@kernel.org>
To: Takuo Koguchi <takuo.koguchi@gmail.com>
Cc: cip-dev@lists.cip-project.org, Steven Rostedt <rostedt@goodmis.org>, 
	Takuo Koguchi <takuo.koguchi.sw@hitachi.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, 
	linux-mm@kvack.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] memcontrol: protect drain_local_stock() with get_cpu_var()
Message-ID: <awb6bJ1-_8zeyTYQ@thinkstation>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
MIME-Version: 1.0
In-Reply-To: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 02:26:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25076

[+Cc PREEMPT_RT and MEMCG folks properly ]

This doesn't look like a patch for the latest mainline.
Which kernel version is it based onto?

On Wed, Nov 25, 2026 at 01:39:00PM +0900, Takuo Koguchi wrote:
> On PREEMPT_RT, drain_local_stock() accesses the per-cpu memcg_stock
> via this_cpu_ptr() without disabling preemption.
>
> Accesses to memcg_stock from consume_stock() and refill_stock() are
> already serialized using get_cpu_var()/put_cpu_var(). However,
> drain_local_stock() still accesses the same per-cpu state without
> equivalent protection.
> 
> As a result, drain_local_stock() may be preempted while operating on
> memcg_stock, allowing another task running on the same CPU to observe
> or modify the same per-cpu stock concurrently. This may result in
> inconsistent updates of cached charges and stock counts.
> 
> Failures were observed as divergence between memcg accounting and
> actual memory consumption. The divergence occurred in both positive
> and negative directions, indicating corruption of accounting state
> rather than a simple charge leak.
> 
> Under stress testing, the accounting divergence was reproducible and
> was frequently accompanied by oops storms. Protecting
> drain_local_stock() with get_cpu_var()/put_cpu_var() eliminated the
> accounting divergence and the associated stability issues.
> 
> Use get_cpu_var()/put_cpu_var() in drain_local_stock() to serialize
> accesses to the per-cpu memcg stock and make its protection consistent
> with the other memcg stock users.
> 
> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
> ---
>  mm/memcontrol.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index f9d80952723c..9b298ce10a7a 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1933,14 +1933,21 @@ static void drain_stock(struct memcg_stock_pcp *stock)
>  }
>  
>  /*
> - * This must be called under preempt disabled or must be called by
> - * a thread which is pinned to local cpu.
> + * Drain this cpu's stock.  Called directly by drain_all_stock() for the
> + * local cpu and as a work item for the other cpus.  Preemption is
> + * disabled here because neither caller guarantees it on PREEMPT_RT:
> + * drain_all_stock() only holds get_cpu_light(), which is a plain
> + * barrier() without CONFIG_SMP, and the work item runs in a preemptible
> + * kworker.  consume_stock() and refill_stock() run with preemption
> + * disabled, so this keeps every user of the per-cpu stock serialized.
>   */
>  static void drain_local_stock(struct work_struct *dummy)
>  {
> -	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> +	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
> +
>  	drain_stock(stock);
>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> +	put_cpu_var(memcg_stock);
>  }
>  
>  /*
> -- 
> 2.34.1

-- 
Cheers,
Harry / Hyeonggon
