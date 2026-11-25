Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44205.1795620461443159887
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 07:27:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=Q22kbEsz;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=oePzjRX5;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Wed, 25 Nov 2026 16:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795619976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0a9q+huuyoIOz8IkHD+r5Bw+xupFItGuXtoD3i7TDIU=;
	b=Q22kbEszPMOtoqXdNesp74j+B4T3Sddk02EMxGU6ZZti/drUuN/TTbmWfO9FVIknny0VNO
	OgqrVaLxdfFAEVBjvROhhG0IeqGFI0fNGDIX9Fz9WT2OU5l/+vX1LxV4MRCesSjHDsL+6h
	FGPMI8d2KLeabCQooQiYnNzHTSy67EjRE6O37eSgAqRmnnQKFuAU9Fk2QXkSq825ehV+HJ
	G5ZyJlmKbZNM2dmYzCHZH6qzfjwVA7wnimfDLlCqnF2ZT7Yi+pvbCEZ33w/w0zCHbjUEfz
	Ts0sqkVdUVRyuswHFpYAKJxad6MSPXIu3VOaPesUNpZ7oLYpFXSHAPwZXbPduA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795619976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0a9q+huuyoIOz8IkHD+r5Bw+xupFItGuXtoD3i7TDIU=;
	b=oePzjRX50n0SqvTlICcaKy9+VF0d2Ledtjo6oUG+P6LBSzqaBex5HradhIL6Xi0oLfxVP1
	TAhWj9xLLXM4MdDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry@kernel.org>
Cc: Takuo Koguchi <takuo.koguchi@gmail.com>, cip-dev@lists.cip-project.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Takuo Koguchi <takuo.koguchi.sw@hitachi.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] memcontrol: protect drain_local_stock() with get_cpu_var()
Message-ID: <20261125151934.-RufHHEw@linutronix.de>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
 <awb6bJ1-_8zeyTYQ@thinkstation>
MIME-Version: 1.0
In-Reply-To: <awb6bJ1-_8zeyTYQ@thinkstation>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 02:26:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25077

On 2026-11-25 15:13:05 [+0000], Harry Yoo wrote:
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1933,14 +1933,21 @@ static void drain_stock(struct memcg_stock_pcp *stock)
> >  }
> >  
> >  /*
> > - * This must be called under preempt disabled or must be called by
> > - * a thread which is pinned to local cpu.
> > + * Drain this cpu's stock.  Called directly by drain_all_stock() for the
> > + * local cpu and as a work item for the other cpus.  Preemption is
> > + * disabled here because neither caller guarantees it on PREEMPT_RT:
> > + * drain_all_stock() only holds get_cpu_light(), which is a plain
> > + * barrier() without CONFIG_SMP, and the work item runs in a preemptible
> > + * kworker.  consume_stock() and refill_stock() run with preemption
> > + * disabled, so this keeps every user of the per-cpu stock serialized.
> >   */
> >  static void drain_local_stock(struct work_struct *dummy)
> >  {
> > -	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> > +	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
> > +
> >  	drain_stock(stock);
> >  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> > +	put_cpu_var(memcg_stock);
> >  }

This breaks PREEMPT_RT and is nonsense. this_cpu_ptr() should not create
any warning here and if it is then something else is broken.
There is no need to disable preemption here, this is invoked from a
per-CPU worker.

Sebastian
