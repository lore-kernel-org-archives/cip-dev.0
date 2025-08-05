Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C88C87FCB
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 01:16:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
 by mx.groups.io with SMTP id smtpd.web10.19610.1754393749611635984
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Aug 2025 04:35:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qualcomm.com header.s=qcppdkim1 header.b=UkUY+mZ/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: oss.qualcomm.com, ip: 205.220.168.131, mailfrom: dmitry.baryshkov@oss.qualcomm.com)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5756COuA029904
	for <cip-dev@lists.cip-project.org>; Tue, 5 Aug 2025 10:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6MqyqJWNT+su2i0PV9Dq1jib
	VxeVp+m7xarMv4uNdaM=; b=UkUY+mZ/do5d/LOeZT1b2eMvT8zMlRbivn4pPtf2
	xKW49RajL0IVJr+uYEbm8YKJoiMB1JNYFQ4EeZ3r0dBt2eMq3r9r8fuj3eS+k8gK
	lizM3E10wX6NbggpEcTK5P696eHp4MmAirEPZH5ct9DdE9+8IjMaVSXePnxE7gVl
	572oFeV76r/uZKS65Lm4VMi5Xbv+oy1IkvjPDncpOKomjrhrSwXzxjGvgkAWHTJY
	gCp2U9U+5DKa3O5JjnCzGlQrcQi28ceZsHdQSIpb/rjmiwi/xIjvi7GDbzXoyKbg
	ubrNu6m6jN0O9efbc52gMHgAMpddcDDVA9oINLDznIU2Uw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc85s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 10:47:00 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70741fda996so70048316d6.0
        for <cip-dev@lists.cip-project.org>; Tue, 05 Aug 2025 03:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754390815; x=1754995615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MqyqJWNT+su2i0PV9Dq1jibVxeVp+m7xarMv4uNdaM=;
        b=oQlw+DzS719lNvinOGINcHCr+Uz05mR4aXZBbmdU8s91g2L3F6CeNWMZGHbLcrUCEj
         4eEiU8fdgVhL5vvxbyrf5Egp2gHvFfn2HMRzwp+qLJWerZrDCQf+VKE+yaOhF9IvLOm/
         ABWSqsr/0XmxFLl8IJf3i+9SjtQSwkn22i7Si4Xr7sf9zVmd2n0QeRZBJW8qnrQtFOgS
         PlAyEW+GLJ6pANZeNGW23MdKfWxNBRGMoZaHcerPgManRC6y1RYOsKXjd+rKei/PBHp3
         J70F1TMOsUGl/A4PRfYbsls9Fxq748KxrCGi1VN3CvYTFKnYa5rWFBhys4bpVb99p9hC
         W+mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7MJX+uRmhiALgb9K0DLYB38LojTHmVUgoHBElnmUk9LDGhIp5Qj0+6erEXqncuEHHHA5BHUVn@lists.cip-project.org
X-Gm-Message-State: AOJu0Yz9EDuBPKpUFenyJUL3+ixHvcDxIIoicCR5NHU0facOVZgEC9ou
	W89nMxS9GSvcVXhuvx7fnImXROvEVa/irgaZPDCbR9W4mfCRpeivB00mCl179Vwxq18UVzaOHFR
	Vj3pbW4r/NOFxJO+h0iCUsW1vGs2jK7/EypwOyLF5rFk0Duh7NWqVZdEpfOU25cb0ycjq
X-Gm-Gg: ASbGncsGKfg+m6RTgn8cKJhH+wjpL6ngVo3P6Srt0oHAgIy3ObUfBTrvgI1hyxQgCG9
	xvBGVqHd0i904gDvsBMxzgc4Di9myGtiz58BBqOKMmcLHLnhEe5hdW2jx8Xg0FcjItbc+iG//ID
	xPCyeA/VryLvlBCmYpk4x3mH1iaVjRsdTnHtx6uYpv+GxiOF1q8F2TIULmF8uz6ggKh8lh/WRyp
	D8MhiLHUcRMQ7vGa9qGSXenfMd87FeaRoWMjHqzoOZLwY+47iqPzavBYAn1kzz/3kk3KuS1SlqK
	J42atr0u62qG8McyKTScd1qy500QYSirq94aZuRoDfD33gqjxeyJMzEFUJ0NqGqh6DdtF7IOPvu
	cu7xneDZv4u/C1gV1TTGxKvGKBvs+jeIE42s5yohHOrWk7/6jDuAd
X-Received: by 2002:a05:6214:762:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-70936313db4mr165964646d6.38.1754390814913;
        Tue, 05 Aug 2025 03:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmShMkZ4kKSVeaIHraWH/PlAWlX7H2EEZv0YV6qAruKBuxlJC4H8uILodqhzr6oCtQ73Ww0w==
X-Received: by 2002:a05:6214:762:b0:704:7b9a:8515 with SMTP id 6a1803df08f44-70936313db4mr165964346d6.38.1754390814481;
        Tue, 05 Aug 2025 03:46:54 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b889ac71esm1875211e87.66.2025.08.05.03.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 03:46:53 -0700 (PDT)
Date: Tue, 5 Aug 2025 13:46:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicusor Huhulea <nicusor.huhulea@siemens.com>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, cip-dev@lists.cip-project.org,
        shradhagupta@linux.microsoft.com, imre.deak@intel.com,
        jouni.hogander@intel.com, neil.armstrong@linaro.org,
        jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, laurentiu.palcu@oss.nxp.com,
        cedric.hombourger@siemens.com, shrikant.bobade@siemens.com
Subject: Re: [PATCH] drm/probe-helper: fix output polling not resuming after HPD IRQ storm
Message-ID: <z4jxkrseavbeblgji4cnbyeohkjv4ar3mbbdvothao6abfu6nf@nqlhcegwtwzf>
References: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
MIME-Version: 1.0
In-Reply-To: <20250804201359.112764-1-nicusor.huhulea@siemens.com>
X-Proofpoint-ORIG-GUID: OVc-VDXTXR-7jyVEfHbPQAgX-aWixvgn
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6891e124 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=Lu6GMi6qvROXTdHYmRoA:9 a=CjuIK1q_8ugA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: OVc-VDXTXR-7jyVEfHbPQAgX-aWixvgn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA3OCBTYWx0ZWRfX1d9KqMG6q9Hb
 HRX61+KX8+EHSEjYAJKLtgiFpv/hZwSpAp95cJkqRLxDk3eK807cma8+cJb4TuY4LYe9VImrLcL
 4SVU7Uxc39D6WsMuhdoXALfS7UdUXMpEShshbcSnDvzK2+M6cSS0NiyB2gNdjagV1zd60Zl76kr
 sJvgjDU/HKY2BHdQCz/gdaXqploY0f59PAUDCcgaJkF0dFSHd/s6S02K9YekYQcjeR1lcOUMhc1
 4gn+nJ9M5m0uWjnoYa96rduCtLIglXMzlM7vwlfs+P33K0ygrq4mn66p7hxmYyh2X4uZcdYbbul
 xYoKQUIBLgk1y+ra3wkJbhlt82wQad0lBjvODzqLr2/OB5za8IM9TQjWoIaQTpTupQgRJvWCfOw
 HQugMX8YZ+wzOE50vqPuW9oTbKVJd5IB/UaV9huIcydUX+nIplxrRVpvETfaZqfrbM5/MZaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050078
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 01:16:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19673

On Mon, Aug 04, 2025 at 11:13:59PM +0300, Nicusor Huhulea wrote:
> A regression in output polling was introduced by commit 4ad8d57d902fbc7c82507cfc1b031f3a07c3de6e
> ("drm: Check output polling initialized before disabling") in the 6.1.y stable tree.
> As a result, when the i915 driver detects an HPD IRQ storm and attempts to switch
> from IRQ-based hotplug detection to polling, output polling fails to resume.
> 
> The root cause is the use of dev->mode_config.poll_running. Once poll_running is set
> (during the first connector detection) the calls to drm_kms_helper_poll_enable(), such as
> intel_hpd_irq_storm_switch_to_polling() fails to schedule output_poll_work as expected.
> Therefore, after an IRQ storm disables HPD IRQs, polling does not start, breaking hotplug detection.

Why doesn't disable path use drm_kms_helper_poll_disable() ?

> 
> The fix is to remove the dev->mode_config.poll_running in the check condition, ensuring polling
> is always scheduled as requested.
> 
> Notes:
>  Initial analysis, assumptions, device testing details, the correct fix and detailed rationale
>  were discussed here https://lore.kernel.org/stable/aI32HUzrT95nS_H9@ideak-desk/
> 

-- 
With best wishes
Dmitry

