Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4472D2ECF9
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:05:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.297.1768885520874729951
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 21:05:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=NBP9Uo49;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.158, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768885518;x=1770095118;bh=OUd4iOGSBybhsTX2RjcBMwxEWTXuFH+DXk0pb
	hwOnNo=;b=NBP9Uo49jhELDLeFBJC1Nvr/gEeQqxzZoPotLSfA0iZKU3Qj9qgjvhHClb+FHfs0zhT
	1JTntOoa+/EymJJ2Hq28BBiUoj/Q46C8sP1Z+672QWknsv5C7PDw3jLERDPQEqnn6L/xH2tbbv5Yx
	dd86neK6zqW4KX2wO+5cgByv2PmVHv4c6/bkcjVzWUfiFKbDiNSO4z+A6eA7pQw21CQil/bKL0PnS
	KW9twpiTM0hU8YgEsFmO3t9jyc69qcX8D83t5kW5y0MlaQPwe3M1mldVYS7ekXx9YUwUdSVASAFGg
	mA4z89ZkakkaANp9p1l0BnRxvV6J6uDFvygo0z16Q8NQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 60K55IRD3491952; Tue, 20 Jan 2026 14:05:18 +0900
X-Iguazu-Qid: 2rWhHaaNAHNnMiOFNw
X-Iguazu-QSIG: v=2; s=0; t=1768885514; q=2rWhHaaNAHNnMiOFNw; m=wofxbvJXAlSkJ3lqKoQ0IOU5tZnISVCg0AiJU12ZwFU=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dwFd63NRJz4vys; Tue, 20 Jan 2026 14:05:14 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIRPu5rA/LB9rTFqQGDXJedHmZaKnMD3/bTe4HZfPyEV1stO7No3DRlTSzVl5OqN9Z98V39vNjTPUjPB3dLkdMYzmqyDW97ZSxmB7K7ocPvexCR4CNRt97rvymRcWVUlMblD6DPbxzfcn9m28ELINYvca3lP82SoyPAJ9GWX4nIhIa45KlJyzta9eWhdx1n88rleRUeJitou8Mmce+lbGdKvCI2muz5aaPZp8Plp3ukBm3seiQmoCG4BUm+xnfL9CRFdMb3FuYsi/Z+rDOyyc1O2F1RLBwqp3JrrmqU316YYokGLNYxiI16KOraDHn9sKhPKxqMW9QnapfRk7Hi7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1frxP3gV5zFY3xqgfUw+t5Aqr7bCQmxoLRHiy4LlUPg=;
 b=I9mE9q+v5keUzNw3uXmaa6OB6IQ7o57IEfQ7tK9fGCUytFr+ie9wL2ff40trQ5bNtWv74YBclQ86KG+ACysVZ6ihxZeHYKR8buPI8VLjTVhup7SsBIJRqe4SBWzFJrJVsNwaYtPAmeJTIAFyB2sNUJCB3aenAEgHV4XGTv+irtbRaNl/FbUQrHRtB09f5hgnePI23loBFXKBC9V3TbkIylYq578LCH5gYN5ylNjdirEzIGYbWZHLpldft4dCxfho/KkDKAQWwuhnE/RdcqZONb3jjvM702UMw4+I6/Pr2CjYqDQWswhR5Szyd0teZau3QYjJ6lHhjlnMAl+mN2bGTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N XSPI support
Thread-Topic: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N XSPI support
Thread-Index: AQHciULkwdmBOYDQDkKobAePI7kzArVZpw8AgADbBCA=
Date: Tue, 20 Jan 2026 05:05:11 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481824CB46BF98F22A89DAEACD89A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260119125516.32220-1-ovidiu.panait.rb@renesas.com>
 <aW5VNiVsV77nEIra@duo.ucw.cz>
In-Reply-To: <aW5VNiVsV77nEIra@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB16870:EE_
x-ms-office365-filtering-correlation-id: d0ca4771-1fdf-4327-d495-08de57e17d71
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WllNZHFSeEgwYWFocDdzK2xZbHRMdlArWlFzcUJCMjlCSEJGVlc4L0hO?=
 =?iso-2022-jp?B?dnNlYnBFbEpvZTNvRGZvY2dya29RNmVydUoyT2ErSmtNWm9hZStjSnpz?=
 =?iso-2022-jp?B?WFpiZkRXWEZsRVlTRG91dEE5bGdBVXk5Zmk3Q09wYThJdUxYVkpZYWF1?=
 =?iso-2022-jp?B?TXRoVUYxUFhJOFluVC9sV3pIY1FCVjB3eFhXQjBvUXVZNG00VEFmOWVj?=
 =?iso-2022-jp?B?WDdhdEJuNzV2VUxYQXpGWFNLTzJ0Q3JZaW00YjYzNnlwUWFBbEdpbjh2?=
 =?iso-2022-jp?B?ZHEzNGxxU2FQZzdqVUdZS2ZUK1hrb0VZZFBwa1M2Mi9nV0V1YkJ6TS9W?=
 =?iso-2022-jp?B?S1F1eWdHTXJXT3BENFBRcU5FZFE3S3dRdkk5RHUwNG02UVhMbnRhMVpK?=
 =?iso-2022-jp?B?OEg3N0wxR3pHUEx5aTZHSUJTV0lrWm1VK25Mc0kvTDJGNytOZmZzSERv?=
 =?iso-2022-jp?B?ODJEcmlhaUkxNTY5a2c2VkhERXZhY0pKN0Zva0lkeldTMWpUc3VOZ1RI?=
 =?iso-2022-jp?B?aHg1bkQ5eVdjZms2SjVQRmhKdGQ1ejRYZHZ6WGlhT1ZqcEdGSlNLd0Zz?=
 =?iso-2022-jp?B?RWt2ZSt6WlJsQlRLYk56N3VFMVFZR2VteVFFSFNDeWZEN2NIeWxGWWNE?=
 =?iso-2022-jp?B?b1FEWU43ekt3VGNXTkkrV0doNzJHSldIK1J2TE5HcUgyNHZPYWtvLzdC?=
 =?iso-2022-jp?B?MHc3MmswQjJRckRIbG91Rm5pRlNVbDJJREtublViSFB5dURzckZvYWx3?=
 =?iso-2022-jp?B?aFNSdGdqRXZ4ckNKVEQ0RENTb1dlUE5uSE9jMUM0Rm50TVRRYThVSDdu?=
 =?iso-2022-jp?B?VTE0UEpibEEydVlYL0FKeTk4L21Tc05tMVVtL3BIN045cTlzR0ZVYmpY?=
 =?iso-2022-jp?B?ODNiVThpbW1qVnhTbnY0UFdmcHQzUHpFc3pDV0hyUGdnTGhjZnp2Q3ha?=
 =?iso-2022-jp?B?STNTbGtJZVlGR1BPeVFWb1lsaXN0Z0tacWVKTWYvQllRcHRGbzJhVFhh?=
 =?iso-2022-jp?B?SDlncUtUc2pJZnd2Z09SUU1HTm9pMGRKdStVQ2pVWnIvdHhtdlhkVmNv?=
 =?iso-2022-jp?B?T0RmTlBVWFZzb3p4UWZ1dGc4RFpMOVpZNU83SjdsQXhTMEN0TlFXR2pq?=
 =?iso-2022-jp?B?S0RoZGlXV1FxYzJjVDA4NFdGNUZiYXZqQ05ua3dmYjJUcEY3akZ1M1gw?=
 =?iso-2022-jp?B?OFk3cDc5UkVVaXd2TVhJSThESWdJQXhJdEROSkJUNzU0ZFAzMlAzVzV1?=
 =?iso-2022-jp?B?TFhUNkpQdnlQVzVoc2hnaWJpQm1Yc3VlTC9WMGlkUldDeHVBL0tRZkdw?=
 =?iso-2022-jp?B?aGlXYTZQV0hlbk1TR0ZsU1BGRU45VWxUTWxIc3d3ZlFpSWRiY2pxbXUx?=
 =?iso-2022-jp?B?ekE5aysvU1V5UjNQVk5oQnFNVTRGS3NUdE5xUStwSElwY0tjRHNNWWgr?=
 =?iso-2022-jp?B?UHZtM0ZyQzNyU2pyRmtBK0J1eGh2cVpNNG5sa1pJZlVyM0VTU3cveURa?=
 =?iso-2022-jp?B?YlZwNlJUQm5nM0ozTjgrYnRaazVGVzhsYTIxTFBZd2g5YmVSc2tnYnFT?=
 =?iso-2022-jp?B?eGVYeDRLT2RjNFVBVXRwd3ZBZFRJb1ZLUHhJandycTdQY1ZhNTduN2FW?=
 =?iso-2022-jp?B?RkE0S2hvczBTQUNTaitzRVR4RmR4djM1em1NNFhvVjI2UG9BR1ovdVB0?=
 =?iso-2022-jp?B?QkwvTmxVcWdlUUtKOGR2SDkzUFFTYjFUNmtZRTFKaWJ2a3BJNFp0OFFT?=
 =?iso-2022-jp?B?QnNhallGYzkrZHorRlNyc2lBN0ZZcyt6eWhUN3IyRERuSnhuT1dwMlVS?=
 =?iso-2022-jp?B?MS8zK0twSDFzVE9HcXp2UXJ6TGRjYVpoT0ZYNzBzNmNaWWo1V3ZFRnhF?=
 =?iso-2022-jp?B?WFhqK2ZvZWlUVytFa3Y4QTZMenBhQStPSnJGU2lVWEVJWGwzeS8wekc1?=
 =?iso-2022-jp?B?WW1iS3dyaE1tWFh1R0FSYjRVa09INEh6MjVNc01HYVIrdlhZa1JJRDdq?=
 =?iso-2022-jp?B?WUs3c042R1MzdXU5Y3E4SGRSbHN0ODM2b1dxV3c2SVM0N0duZUMzVHJu?=
 =?iso-2022-jp?B?Q3BXUGNRRzFYUDg1SGNRU0xoUFpIVWNYdlYycW9Pc01kWW9tUnBXVXU0?=
 =?iso-2022-jp?B?bTdMZzdHOEVZUUNTKzkvby83aXF1U21tQ0hsc2QwZlJYamlraFVMcXNm?=
 =?iso-2022-jp?B?cmpvZDI0QWZZQjRzWmxjSGltK3pQWk93MzNVRUZaeURHS1p2MjFHYTRY?=
 =?iso-2022-jp?B?NkoyQ1I2cFBaSVpGc2V2cERsbjZxMTZpTkwrR3gzZGtuZHM4TWhzclFw?=
 =?iso-2022-jp?B?SkZIUEFxSFp2cCtlTVhtVGh5VWpPU1FOSTBqWjlqL1RhdzFxN1BBL3Iv?=
 =?iso-2022-jp?B?RlYvekk9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Sys3eUZMU1hybjd4czlqUUI3a05qYzFxZS9ZazZQcXE3UGU3bTZZTldx?=
 =?iso-2022-jp?B?NFNnQ1lENjRGWnV5K3I3YWVNS1ZtR09DRHV3d3hWNFdyVU9SVklIdDli?=
 =?iso-2022-jp?B?L3lXZDlDZmpFaG9tRDE4WHZEMTBaVGk2S2dscFovUXRyVllqY3hNMWRP?=
 =?iso-2022-jp?B?Wm9tODZDSVN6S1ZsbkVhRlVoRERDdWJhb2o0VlZuQlRBUWYwQ1hvcWUv?=
 =?iso-2022-jp?B?eE0zRkxobFNXTWl0WkVsMjlnaTRKNzc4cm9Hd2ljUFNlQmFOeXVZMUpJ?=
 =?iso-2022-jp?B?anczOXBiVHI5Ujc3aFFqdDZJMG1RSFY5MzU1SDN6Slc0Y3o5KzROVXV6?=
 =?iso-2022-jp?B?cDUrNHZhTUdxZit0cHJUOTJnTEQreFRzMkVJOE55bW1MUHR3a2tSUnpZ?=
 =?iso-2022-jp?B?UVRyakJxK2lSZC9xekFDS3lRZTVTOGp6SkxwVmlxQkgwOXFCb2N0SS96?=
 =?iso-2022-jp?B?aWIvNTBRcW1wK1pyQkIwYzhyU29WQkM1Q3FrcnIvOVo5RHRta1kra2lE?=
 =?iso-2022-jp?B?SnVVdHJHVzNBTFZyMXJZTDFWWUVMaGJyTlFiUkRkUjNYOEtjdlViOEUy?=
 =?iso-2022-jp?B?YWRlZmZxNTdRNWZFeTZaOHp5RjZ0UFRRRTFUN29XRjdNd3NaNW04YXR4?=
 =?iso-2022-jp?B?RkQ5UUIvUGlxdlQvL2g2L2pWeDlxMGY3L3U3VDZuWUxYUWdyNDV3WVNv?=
 =?iso-2022-jp?B?YXdkdVpMOWRSY0RYOXIxNkJzbnpEZS9sSHl3TTRDQmM0ZTl0SE9QN0Mw?=
 =?iso-2022-jp?B?TnVZK3VRZzB2ME1GN2x1N29KeWl6VTF3eDVoVnd4OHI0T1dOcTV2UFJk?=
 =?iso-2022-jp?B?b0dYcU90aDh1K0hnUnBXcUtYOEl0YU1IUTk0UUQ0b05Tdk5hVGFEQzZR?=
 =?iso-2022-jp?B?NXBGazEwNG5nTHdJa2lJNDZxbWg1bXM5Q0Z2UW8xbUE3Ym1DNWlJVlhP?=
 =?iso-2022-jp?B?VEY5OTlVK1ZaUUxPZUdJQysxY2ZMcWlpOU5YeG1FaC9DcDNySFdsZ1k5?=
 =?iso-2022-jp?B?YTRWVHV4d2diWGRrMkRXTElnb3JtRk8wYkJxWERCN0NnbDNJL24xbmpF?=
 =?iso-2022-jp?B?R2llOXBJMzUzQm1DQnBjaVJPM1J5eld3bFhGSVVoVjRpQXAxMFpENFdz?=
 =?iso-2022-jp?B?Rkx4QUVMTDJjYW0rTWwxWDVGbkNDUVZ2bFh2ci9PWkg4N1Vvb3k0L3Zk?=
 =?iso-2022-jp?B?ZTdGbzZqem4zVlk2ZnE2d1F1bGoxUHFMTlFNZGErL3VNK1FpSVo5WG9s?=
 =?iso-2022-jp?B?aGFma1ZWRm0vdXdEY05GclIreDR3UklyZXFKSmMxQ0NkWmFiWnM5bUds?=
 =?iso-2022-jp?B?NlV2bzJyV1JlVTNFbGRwdzhBN0dYa0tCb3JGdVNvcVFkMzNycTJ3aFd4?=
 =?iso-2022-jp?B?ZkNLMW54TERJNE1yaTJWYlRYb1FHcUpCdk9JR2I3TlVodmdNZEZvVmVI?=
 =?iso-2022-jp?B?SXBtcTNQaW5DcDYvR3doM1ovVVFrckRDQUdoeDdvbThjbTFYQUJZS2tm?=
 =?iso-2022-jp?B?V08yZFBOR0FudDZOYm1vVXF5Nm5IWUs1d0Vrc0JJTDZhalhLWWRSSG9F?=
 =?iso-2022-jp?B?QVFYWDNNYVlXYnZxelJLQ3hQMDByLzIvVlE1L1YwL3krcTE0T3U4d2l3?=
 =?iso-2022-jp?B?NGZwdEJNL3l3dU5LZ1lBK0kxZklyMFFsZm93aVcxY2lzemM0cDZIVUlo?=
 =?iso-2022-jp?B?dG0yR3k2Rk1IdnRnNlJzUHU1MVJhMC9WaHdPbDVRaHh0bjZKRVRwY0ts?=
 =?iso-2022-jp?B?ai9XQ012MC9YR0NXTVNzM1gxc2x6UEpuN01DUVlGTTBLOW8wRnF6NEdC?=
 =?iso-2022-jp?B?d3A3TForVk1naHNSVUJOcDkyMWs2SG42UERHSThFS2p4aVVla0hjTE5B?=
 =?iso-2022-jp?B?aW9vbFNRd3E1Y3BjRzRZdE9ITjJnNFBiNWxsZTE0NE1Ob3VYR1JDQ3Q3?=
 =?iso-2022-jp?B?YnAwdTFKcUtHR3Q2Z0k0clFOYWRIcmhtZVA4WEZTWVovT0xZcUdrWHBn?=
 =?iso-2022-jp?B?RVJzKzFBeW41ZURZNXp1WGJKUzZQcDFsTGZwTTgvc0trUlh5NGpCajFJ?=
 =?iso-2022-jp?B?Y08rZzdwVVpkYVVRRnR2OGxwYjVMeXdWL2RjTFhicmc0NUd4RHFrSnNH?=
 =?iso-2022-jp?B?SVl5WXI2Wm4zU29SUnpIbDQxOVhRWG1xS3pOb0I1SmFwU3BoVi82YlJ2?=
 =?iso-2022-jp?B?bzNTRWx6TFdDb051NmhMNWFJK1VSMkJiWnFKVmxCWFRkQ0pwUGdxUkhF?=
 =?iso-2022-jp?B?Nk4rdlMrYmdJUWU2dndEL2ZxV3JvVW1rc3NzVW9IZG5aWWE2TUY0ejgr?=
 =?iso-2022-jp?B?OXg4ZWUzTHdtcVJMRlBzL3BOblBIdy9uRGQyNEpHWEs0S3RjUzZHM2JR?=
 =?iso-2022-jp?B?N2hBRE8yU3FKRE80YXdOYlJuME9GSmQ1OC91SFVCNW1McGxzY01QSkhX?=
 =?iso-2022-jp?B?SWxDbXVXbThyVVJyRXBEaDJoaU1HM01xSEwwcnZ5UER5cFVPZVlMdmlo?=
 =?iso-2022-jp?B?aHYvdWEzTGdjbmpWNUR0TFpkYkEvYUhvdG9uSzJvN2lBMXBteWFjbVhZ?=
 =?iso-2022-jp?B?dTVDanMwMD0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ca4771-1fdf-4327-d495-08de57e17d71
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 05:05:11.6721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pEV2J+y5uuVI3/ybYHco7RPa6RgMITi1rjH/U8eJlvA7rlFmehJ4Td8l/4d9ttv3+9PC2oqtkMe7YPpu6fNYkVeFV6BcXoCuyVrj6dVQDOjJJLTdW2nChEw0xBddrzSY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 05:05:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21683

HI all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, January 20, 2026 1:01 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.12.y-cip 0/5] Add RZ/V2N XSPI support
>=20
> Hi!
>=20
> > This series adds XSPI support for the Renesas RZ/V2N SoC and enables
> > the
> > MT25QU512ABB8E12 flash device used on the RZ/V2N EVK board.
> >
> > Patches were cherry-picked from mainline kernel.
>=20
> This looks okay to me.
>=20
> Reviewed-by: Pavel Machek <pavel@nabladev.com>
>=20
> I can apply the series if it passes testing and there are no other commen=
ts.
>=20

I reviewed this series, looks OK to me too.
I applied this with Pavel's reviewed-by tag.

> Best regards,
>                                                                 Pavel
Best regards,
  Nobuhiro


