Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFF6EEA87C
	for <webhook@archiver.kernel.org>; Fri, 13 Feb 2026 02:40:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.62619.1770950397502651982
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 18:39:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=PBSjmXia;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key1.smx;t=1770950380;x=1772159980;bh=
	h+jvdTPZkcCE1HgJ+ha+2tSTUcHrBNUW/FZMaIoS9GY=;b=PBSjmXiaZLZkEZ0z9D25VjXsYkHIj9
	Fh8Bx1w/323PxvARLkDLGVziQzoa0jQNik3PHH8ZrftJUpPNAoU0uvy6z44rS89bkPjNnybE28jtz
	ULPNe6h2LsfabKuRWcxJiva2CQYyLm2ugG+1TkLQ4Wt3HDIew6WSzZPznOaS+Eccw6OL7rQ+XwdeS
	wDE26HbBBUeV2vPx1dE5X1x4BJ6BUSyfzC2sWtrB/Akmb/S99/QquPVnpKJE6JS/WGnrvGeipuDqw
	v2oD7EwmguapxHmQLap+UwzKIhBjlgt2xd59mcUEdpMZMV73yRXiHvoyTQROvM3hXxhBh3g1G70mx
	qQIA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 61D2dcv61371569; Fri, 13 Feb 2026 11:39:39 +0900
X-Iguazu-Qid: 2rWhnGXnE0uZnisQnI
X-Iguazu-QSIG: v=2; s=0; t=1770950378; q=2rWhnGXnE0uZnisQnI; m=ey/8XpedDckT2/sB+iIEAbW/ifvFPKw6E1IykqbxoDw=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4fBxG11t9Fz4vyh; Fri, 13 Feb 2026 11:39:37 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCMW5g5Ek/ixGbLP2uREmraZFaqJZf2HNJrU2zxBeQpVRBFi6MwWRMeaH7tQ+Fx+Guzg4ncOLBaMOLBA7luAw5kuTYLMkYtwrQy9ZuWDHCfjL+hzYR8iWBdVVCvDFQ6ZdhzssVTZEIRDxRfTbbxUcSZnY9/VN9mnDazEL+OVyGlJwGkNQKHZjWbKv7T01xVr/ZCl1jJ3E9M0ogzKz/VTLfPqCtdY6lFgU9BzKOGOZxwobBrO7dJj2emvboRiM70JeZvrNrOJIenzIBSxy5LG+nZxdGEgOj7Ssdt0Dp/4H2v3mvHoHr4Bvq+8mcc9QV/Xv6pCZX3uWTs4PhCOFKMhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBXtASHdp2BZtsAHT+dJTOjGeiN4yRD0i7bSzZeJQWs=;
 b=pH+HN+goEWeqT8bWSR4wcxfu+lfZdsmc59FTZ59kZuwIdPvQjHVr12MC6aIw+Zpwi7c0TSazAVsgBKz0GGIGV+iq0y0CWcB4l69N7+mVTbS+uWPJBt8V+qgxrXMFJgqkViS0OI+/g6i0aez9goRDrUzOZ2Xm7xDv966o+GYHgHCBvVAW1PdVsvou0bQQ6SwpjdFAy3Ffl4QxWRz5gPYVba34P5N+SdVA2Su8pa/DeG6DcBatc5YrazIk90bT08yI8URSMHLt/X4Lgva6Q+jGWb39ExDLMlbsIT31XntaXZ4XKpLPxBl3g6LZct7rexheG+WnQ850KfvGe17HH/rDwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@nabladev.com>, <masami.ichikawa@cybertrust.co.jp>,
        <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <chris.paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and v6.12.69-cip17
Thread-Topic: [ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and
 v6.12.69-cip17
Thread-Index: AdyckeQ4+Iy8eJbnQHmvIKc9dujgfQ==
Date: Fri, 13 Feb 2026 02:39:33 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818948CDCC24C4DE8F193D0CD61A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB17893:EE_
x-ms-office365-filtering-correlation-id: 75d1c8e8-8488-4b82-f97c-08de6aa91eb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|38070700021|7142099003;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eThISUxNV055LzFhYzlvT1JpMkdmN1NCS2V1OUI1Qk15R3ZycWt2TUgz?=
 =?iso-2022-jp?B?clZDUUpMNHU5WUVkZUNVRzQ3Z0U2RFdnN3J3QTZWRUd3bXVlNExLK1pQ?=
 =?iso-2022-jp?B?NjVBd2RiamVlUThkQ29RWW1mbjUrekRrU3Q3Qm9UTkQzTnR5VWpNbjZY?=
 =?iso-2022-jp?B?T0FqUG1qbWNvM3VBSWF1eEtyZDlWa0I3UHZsUDdOUXc5ZnNGZkhDRnUv?=
 =?iso-2022-jp?B?RWt4NGs5a1dWV1c3SGJJR252NlZwaXhkSDYvTmRXdVNuc1hyUTFlQ3VD?=
 =?iso-2022-jp?B?WHlmWllrWTQxWFFVbWIvSmtpR25Bdi9UM3FGZnE4Ym5HdUpPQVo5Wkc3?=
 =?iso-2022-jp?B?a2txMEFkTXVlcTZHTmtFNkc3eC9mTXpVT1EyeGhGdTRzSk44MzNtL3M2?=
 =?iso-2022-jp?B?NTA3WVNpSVJwOTcxUG1IdnZFZG90QnMvV0lucGFEWXhVMUlhc3V2QTJN?=
 =?iso-2022-jp?B?QWMzUnVIN290bGNxUVNiWVU1c09sU2ZybE9yVnJoTHVLUGVOVDBnci9B?=
 =?iso-2022-jp?B?UGRoaCt0cUROQ2ZrM2JMSEFnVkxNTGl5YnlzVFRQVThMdVQzZXVMcmla?=
 =?iso-2022-jp?B?ZE16OFhYRGVDRWkzYnF3bEFMZFpZY1Z5L1dpckVyQWl1Ukx5bmJibDJW?=
 =?iso-2022-jp?B?eXVGRmRJR1VsZjFuZDUwN3JvcXA4dE5GV2o4WGtyaWZDTVIydm8yOEFr?=
 =?iso-2022-jp?B?RTBtUkE1eFkyaEZhR29EQnZsOFIvWjdwT2NxY1QrT1huQkluZFR0UXA3?=
 =?iso-2022-jp?B?U1pkdUlnMWg0bWFqc0V1ZkRSTTh2MFYrb2hNRGtMbFVEelk0dFhucUsr?=
 =?iso-2022-jp?B?MXNxT0VDQ055dmc2NzdVcHRNSTBXY0x2NUs0NmIwZTNGYmpkbGR6WFM2?=
 =?iso-2022-jp?B?ZGU5L0NrL1NzMW1hMHF1TmFIclJkRU5pejJGZjkxTjRNOGRSVi9RVERz?=
 =?iso-2022-jp?B?NDdiL0tkOEx1ZDB3MXh2RC94SnlsUjUwc1JCU1MreXkxRG9BUjNQWWpj?=
 =?iso-2022-jp?B?cjBNck12UnE4SXNtR1JVZVdiL01LUkFIWG5YYlk1YnFlaHpTejQxaG5G?=
 =?iso-2022-jp?B?WVNCMjljTjMyUHR5MU5uN0g5SGgvRmIyUlN0QThFSXhKYmNZRit5SER1?=
 =?iso-2022-jp?B?Z0FIVUpQeXN5VUtJLzI0SkRxRjN1ME8zK0srak5Wd05qcXpQS28zcGRs?=
 =?iso-2022-jp?B?RDROeVJnaUFlOEo2dFVPQi9Sa0VqNkU3QlBTVno1c1pCV09FSkYzVXJY?=
 =?iso-2022-jp?B?NEVYQ1Q4cGtMSGVGYU9IUEF2Zkxha3RaQlNadnp0ampraXNGcXV0L1hW?=
 =?iso-2022-jp?B?cXU3NTRRMGkzMGJzK2Q0aTZsNlFRMS8vNE1GRmpJUTBlNW9IRWhiWTlj?=
 =?iso-2022-jp?B?TVlvN2ViaG1DVjJnUXFmQm1FT0ZXa0lIYnBCZW9kcDJiZmJhR1FTdU92?=
 =?iso-2022-jp?B?UHRKUDJMVlZPUC9NMWNjbG1NWFJEVTA0STduUy8xTTlnVGRRaFlKUmd3?=
 =?iso-2022-jp?B?NHRoSFc4a05wR2E5bGFBRDNCS2VIbjgrSk1ST3F3aWI1S3pQaS9RVmIr?=
 =?iso-2022-jp?B?NS9wT1dNNGhtYm9sUTFsdFNxY3pqY0FVeW9QKzdtZ0Vlb3hsMXR2dFlH?=
 =?iso-2022-jp?B?cGdSblJvMU1EcmJsZkNiT0dHMUs3bVAvWkFIQUovY1JYRnVzS1YwcWg3?=
 =?iso-2022-jp?B?Tk5IRi9xdWdQZ2k3dTdyTmxaTUxscE5iUDZwanJqZWlaTUNMcHYvVk56?=
 =?iso-2022-jp?B?L0s5NU1zRDVEa2lnWGdVMDlaYTJCc2pRd2laRU1OSy9aNHZkMEtJVjR6?=
 =?iso-2022-jp?B?TGxkMm14TlRzSHBLRWNNSGIvN2xCcUtBL3JtYU5Sc1hQakY1U2NBajlm?=
 =?iso-2022-jp?B?bldteXplY0tLQUlLTGpoTjlzSDdYYjl3RHpPcWUxdUtMTHNaSXNZaGdy?=
 =?iso-2022-jp?B?TDFXSDVyRlZHaGdwK2xtbHQ1cmkyQTYvUytvWjBYemRSZTVNMUVrS3d5?=
 =?iso-2022-jp?B?QUNuSVhvZzFkc0JuREtIRWxzNWpncUh4L29KeHRWTTlnQ1pqMnA5RGxU?=
 =?iso-2022-jp?B?Q3B4TERNS3YrcjNDMUxXUnp0a05lZGZYUEd4VkwxUmNKTUkxQ0JQdnNO?=
 =?iso-2022-jp?B?c2N2cUszRDBJMUZSeWU2WHR0ekd4cHNwdGVRTVhlWWZTcnlCNDBBUlJQ?=
 =?iso-2022-jp?B?WUlUZEhlTGRITzlzUzhDY1BoY3Zrakh3aTdteVJ2QmtHRG9kRWRMNnhY?=
 =?iso-2022-jp?B?cWFwbnRxaGZ3VllMQVRTd3N4V0xLem91bHdKbHdmN3pjYUJCeHErRktk?=
 =?iso-2022-jp?B?eGQ0Q2ovL2IvN1kxc3VHUkFwSmhCb0xvWExPWUxlL0NVRURka0tRM0cv?=
 =?iso-2022-jp?B?SU1GT3c9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700021)(7142099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ajN4Qm9YOXlvY21Bd0xHTWFwNnhrSjlGQ3pVY2ZLemhkV3ZmbmU5bzFX?=
 =?iso-2022-jp?B?THBJd1JzeHBvL2RUQ09HeU40VVdVMVhKSWV6eG44R0t1Y2tkZjJaS243?=
 =?iso-2022-jp?B?RUVFbkZKZWRFYXhSYS9OYWN1SmcyVnBOd1JhUEE2OUlhTkdtejNoRUVx?=
 =?iso-2022-jp?B?RVNwUlNvVmhVNE5FQk82SElhUFR5a1JEd3k2YnRZVElPUlZRZjJuVmhY?=
 =?iso-2022-jp?B?NjN1engzZHFOVDdWNll3Vjh3eFBqTlhwNjhJWWNMeDAyWE80UVBzY3lh?=
 =?iso-2022-jp?B?NmxJVG5Zdi9mbWEzL1dyTTNBaERGSVZaclQyMC9TejVTKzR0ZnZsc3pR?=
 =?iso-2022-jp?B?ZkxhRVlwdDNvMmNKanpZd2RYYUJ6dVppRExLdStDQ2F5Vkh2WWM0YXNF?=
 =?iso-2022-jp?B?cEs1T3VIVTkxQXpVckNUT1BDQXFGTmEvczFocE0rVjZjLzBrdVJhc0Ux?=
 =?iso-2022-jp?B?cUN1ZWVmTk1taUZyc1dwdW9SSWZKdkRGVXdPTHl2UHBjWjRUUDd6VDBi?=
 =?iso-2022-jp?B?K3ZaSTA3bkR4YlkyeEhZeWwzdTBCRWFUYXhKNzFXMjhXVkZwWDJKbE9o?=
 =?iso-2022-jp?B?M1pMYVYxSUdKV2tzbDMyc1U0V0cwZFdMQUFqRUkvd3ZZNzBFVDFSUThT?=
 =?iso-2022-jp?B?elVNaWVncjEvQ2VIYkJFc0VjVW9zOTA5VE5jTDBFYWJGbWZFbjNJaEVs?=
 =?iso-2022-jp?B?QkdDNWVKY212NmpvS3VrenJqT3R1WkkvRzFOSk1NQ2ZpVmxmdDc3VVNK?=
 =?iso-2022-jp?B?eHpKWUQyVWg1WVhCMGdubWVTU1d2STNiQTVHYW9GdWIxYW9qME1rMWFO?=
 =?iso-2022-jp?B?Q2lzRnNMdk1uZWNTUFVjTnR0VTlpQVk3MzVDWlhnM3YxbHpsQlpSSlkv?=
 =?iso-2022-jp?B?QnpGWUltNUsvcThZVXdYc1lDay90STZmSnRRNXNaL25PTG02Ri9wZ3Iz?=
 =?iso-2022-jp?B?blphVnNHSkxua25IK1RWaFpOYlNjNVYzV3FZS0JKZXR4aGtlVEtmREx0?=
 =?iso-2022-jp?B?ZXNPcHVnTE1iSlFlUFV4bUE1VEZoQUpTYlBlL1krZURhT09SRUxxOHYy?=
 =?iso-2022-jp?B?TXBpVi9HdWRUaUtUV3pDTEprbURZeDhiUStSNk5DanlJMGJ6UWs3aEF5?=
 =?iso-2022-jp?B?YXMxaWt2REo5UmpucmFXWndkMmVaMDR3TjNzc0hXMnlCSkVncGZEc0My?=
 =?iso-2022-jp?B?QzdPVFB1SmhIRVg0WW5rSGRtOVFlbUR4bGVMYnliZm53WklhM0FDU0hP?=
 =?iso-2022-jp?B?Y1Z5RzhadmFTUG5WS25EM0NOaWtWdkFnb3ZndFVXQS8xQnJLQy92RmRG?=
 =?iso-2022-jp?B?QkpuSzNKVVRqd3NKOVpCbGRDYWhuQ0o3dmNoNmVKQjJuTTZjd0FvT2dK?=
 =?iso-2022-jp?B?a1VSZXNzbkJjQVltdGtZWlVma3RFV1VsS3Z2dm4zM1g3Vms3aytZYW9s?=
 =?iso-2022-jp?B?eVdBT1hyVE5UVS85eGZOSktxbE1qSzRwNVNxMTkxb09NeTlGQzRYeDFy?=
 =?iso-2022-jp?B?Q21WNVBJbUFoc1R0czdTMUpSNVF3a1plcWhjK3k0L21rL25IbGdaUVRE?=
 =?iso-2022-jp?B?ZVczMCtONmNFVEJnNG1tU2hyNTlKby96L0x6M3RxdnNSaW5QcElDN2VU?=
 =?iso-2022-jp?B?SmNmaXRaVThXMkREdktnSklNVStJZXM0azdrTStvbk1XNDhndWFKNXFv?=
 =?iso-2022-jp?B?ZGozTE41NnM2Q1pEUnhqK2NhMXFzYi91WDJidXlpNHNRb0hoZ2VMZ21C?=
 =?iso-2022-jp?B?Vjh4ZFlORERObFlwNWJ3Q1VYSUhFQXh4OGV5TEE0cllqZ2hDRjBOOFNM?=
 =?iso-2022-jp?B?Y1RYMFYvMHdPM280TVk2d0Z5ald4a2RadGNwa3I4Uk00WWdQbjNBQnZo?=
 =?iso-2022-jp?B?cGlZNmt4NFdxNTNoMkdOejBCRmpIY2dJbkZSV1JEU1RoSmgyYWs0SUpo?=
 =?iso-2022-jp?B?S0JXak1WTTU2dStLTzBLaWhJNW5RWmtGVjdUbUF5OGdqT0tJakk4WGtP?=
 =?iso-2022-jp?B?aGN5dGt4TmNSY1dZSHRjOFZvOUhyQU1Lamc1TVl1dkdXSmpCd1BsbjRx?=
 =?iso-2022-jp?B?QmlRcVFRVTVtS1d3NWdBUHpvaFpRV0NsVG11ektSbHZXcHJvNVdYaW1Z?=
 =?iso-2022-jp?B?UnhUQ3dXWU1uWWxXamZoWFljNjEzTEYyNzZVRUgrVGJVRDlmdkdjOTFB?=
 =?iso-2022-jp?B?QnV0cXlDbGJBY3d1VGcrd1R5QnNCTk43Qk96Q0xva29ZZUFTclplVUNM?=
 =?iso-2022-jp?B?ZXRpQzRMayt0alc5ZUhaVG9vakNVaVcva0lUa2lXOFBwNlcvM284Zk1D?=
 =?iso-2022-jp?B?QXhvei96Um9qbEkyREpPbVhxZTBMU1VYaTBEbC9ZZXFNOWhDR1ZVTmcr?=
 =?iso-2022-jp?B?bldwRlQvWC9keEZNWGxqUnVNN2FpZXh3T0JjR09OeUFWZ2ZvMkxzT0pE?=
 =?iso-2022-jp?B?RmZYM3BHckZBZGFmemdNT21vUlF4NmJSMHhKOGJzbGozL0FtWUpWcUpJ?=
 =?iso-2022-jp?B?dGR0K2hTNDJ5bjNnL0R4WXNqUzNNNzJUM3dyNkM2ajd0TVcxUTRPcXp5?=
 =?iso-2022-jp?B?NEg2QXBRQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d1c8e8-8488-4b82-f97c-08de6aa91eb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2026 02:39:33.0355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MI6ehFlMHKV0nSB4uU3Yr7o8Lr3Z7f13W8yZlrosiJnXlWzZ8NUqW8a0r3PgYswP4zRIefybaL4RucLShMtLk0BOmWko43PErYRevVB20ZApbIfscnmpwgEJjzK+K2Tw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB17893
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 13 Feb 2026 02:40:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21868

[ANNOUNCE] Release v5.10.249-cip69, v6.1.162-cip51 and v6.12.69-cip17

Hi all,

CIP kernel team has released Linux kernel v5.10.249-cip69, v6.1.162-cip51 a=
nd
v6.12.69-cip17.
The linux-5.10.y-cip tree has been updated base version from v5.10.247 to
v5.10.249, the linux-6.1.y-cip tree has been updated base version from v6.1=
.159
to v6.1.162, and the linux-6.12.y-cip tree has been updated base version fr=
om
v6.12.66 to v6.12.69.
This release includes updates for Renesas ARM64 SoCs. Please check the foll=
owing
information.

Information about this release is as follows:

  v5.10.249-cip69:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      cef11f8ad4f7713b1df34ed101be4a0ec1e1a216
    fixed CVEs:
      CVE-2022-48744: net/mlx5e: Avoid field-overflowing memcpy()
      CVE-2022-49168: btrfs: do not clean up repair bio if submit fails
      CVE-2022-49465: blk-throttle: Set BIO_THROTTLED when bio has been thr=
ottled
      CVE-2022-49711: bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_b=
us_remove()
      CVE-2022-49743: ovl: Use "buf" flexible array for memcpy() destinatio=
n
      CVE-2023-52735: bpf, sockmap: Don't let sock_map_{close,destroy,unhas=
h} call itself
      CVE-2023-52975: scsi: iscsi_tcp: Fix UAF during logout when accessing=
 the shost ipaddress
      CVE-2024-36903: ipv6: Fix potential uninit-value access in __ip6_make=
_skb()
      CVE-2024-36927: ipv4: Fix uninit-value access in __ip_make_skb()
      CVE-2024-40928: net: ethtool: fix the error condition in ethtool_get_=
phy_stats_ethtool()
      CVE-2025-22022: usb: xhci: Apply the link chain quirk on NEC isoc end=
points
      CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_r=
ef_all()
      CVE-2025-37830: cpufreq: scmi: Fix null-ptr-deref in scmi_cpufreq_get=
_rate()
      CVE-2025-37835: [REJECTED]: hwmon: (ibmpex) fix use-after-free in hig=
h/low store
      CVE-2025-38022: RDMA/core: Fix "KASAN: slab-use-after-free Read in ib=
_register_device" problem
      CVE-2025-38119: scsi: core: ufs: Fix a hang in the error handler
      CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bi=
ts
      CVE-2025-40110: drm/vmwgfx: Fix a null-ptr access in the cursor snoop=
er
      CVE-2025-40215: xfrm: delete x->tunnel as we delete x
      CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy t=
ime for states that were never added
      CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in OnAs=
socReq IE parsing
      CVE-2025-68257: comedi: check device's attached status in compat ioct=
ls
      CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_a=
ttach()
      CVE-2025-68261: ext4: add i_data_sem protection in ext4_destroy_inlin=
e_data_nolock()
      CVE-2025-68264: ext4: refresh inline data size before write operation=
s
      CVE-2025-68266: bfs: Reconstruct file type when loading from disk
      CVE-2025-68282: usb: gadget: udc: fix use-after-free in usb_gadget_st=
ate_work
      CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in =
cake_drop
      CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistrati=
on
      CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write=
_lock
      CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access(=
) when file system corrupted
      CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size =
validation
      CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_form=
ats()
      CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_l=
ayout_stateid_invalid
      CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list =
with regulator_list_mutex
      CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflo=
w in rtl8187_rx_cb()
      CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_e=
xtent()
      CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect
      CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_togg=
le_emumouse
      CVE-2025-68372: nbd: defer config put in recv_work
      CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in asymmet=
ric_key_generate_id
      CVE-2025-68733: smack: fix bug: unprivileged task can create labels
      CVE-2025-68740: ima: Handle error code returned by ima_filter_rule_ma=
tch()
      CVE-2025-68757: drm/vgem-fence: Fix potential deadlock on release
      CVE-2025-68758: backlight: led-bl: Add devlink to supplier LEDs
      CVE-2025-68759: wifi: rtl818x: Fix potential memory leaks in rtl8180_=
init_rx_ring()
      CVE-2025-68764: NFS: Automounted filesystems should inherit ro,noexec=
,nodev,sync flags
      CVE-2025-68767: hfsplus: Verify inode mode when loading from disk
      CVE-2025-68769: f2fs: fix return value of f2fs_recover_fsync_data()
      CVE-2025-68771: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
      CVE-2025-68773: spi: fsl-cpm: Check length parity before switching to=
 16 bit mode
      CVE-2025-68774: hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_c=
reate
      CVE-2025-68776: net/hsr: fix NULL pointer dereference in prp_get_unta=
gged_frame()
      CVE-2025-68777: Input: ti_am335x_tsc - fix off-by-one error in wire_o=
rder validation
      CVE-2025-68782: scsi: target: Reset t_task_cdb pointer in error case
      CVE-2025-68783: ALSA: usb-mixer: us16x08: validate meter packet indic=
es
      CVE-2025-68785: net: openvswitch: fix middle attribute validation in =
push_nsh() action
      CVE-2025-68787: netrom: Fix memory leak in nr_sendmsg()
      CVE-2025-68788: fsnotify: do not generate ACCESS/MODIFY events on chi=
ld for special files
      CVE-2025-68789: [REJECTED]: hwmon: (ibmpex) fix use-after-free in hig=
h/low store
      CVE-2025-68795: ethtool: Avoid overflowing userspace buffer on stats =
query
      CVE-2025-68796: f2fs: fix to avoid updating zero-sized extent in exte=
nt cache
      CVE-2025-68797: char: applicom: fix NULL pointer dereference in ac_io=
ctl
      CVE-2025-68799: caif: fix integer underflow in cffrml_receive()
      CVE-2025-68800: mlxsw: spectrum_mr: Fix use-after-free when updating =
multicast route stats
      CVE-2025-68801: mlxsw: spectrum_router: Fix neighbour use-after-free
      CVE-2025-68803: NFSD: NFSv4 file creation neglects setting ACL
      CVE-2025-68804: platform/chrome: cros_ec_ishtp: Fix UAF after unbindi=
ng driver
      CVE-2025-68808: media: vidtv: initialize local pointers upon transfer=
 of memory ownership
      CVE-2025-68813: ipvs: fix ipv4 null-ptr-deref in route error path
      CVE-2025-68814: io_uring: fix filename leak in __io_openat_prep()
      CVE-2025-68815: net/sched: ets: Remove drr class from the active list=
 if it changes to strict
      CVE-2025-68816: net/mlx5: fw_tracer, Validate format string parameter=
s
      CVE-2025-68818: scsi: Revert "scsi: qla2xxx: Perform lockless command=
 completion in abort path"
      CVE-2025-68819: media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100=
_i2c_msg()
      CVE-2025-68820: ext4: xattr: fix null pointer deref in ext4_raw_inode=
()
      CVE-2025-71064: net: hns3: using the num_tqps in the vf driver to app=
ly for resources
      CVE-2025-71066: net/sched: ets: Always remove class from active list =
before deleting in ets_qdisc_change
      CVE-2025-71069: f2fs: invalidate dentry cache on failed whiteout crea=
tion
      CVE-2025-71075: scsi: aic94xx: fix use-after-free in device removal p=
ath
      CVE-2025-71077: tpm: Cap the number of PCR banks
      CVE-2025-71078: powerpc/64s/slb: Fix SLB multihit issue during SLB pr=
eload
      CVE-2025-71079: net: nfc: fix deadlock between nfc_unregister_device =
and rfkill_fop_write
      CVE-2025-71084: RDMA/cm: Fix leaking the multicast GID table referenc=
e
      CVE-2025-71085: ipv6: BUG() in pskb_expand_head() as part of calipso_=
skbuff_setattr()
      CVE-2025-71086: net: rose: fix invalid array index in rose_kill_by_de=
vice()
      CVE-2025-71087: iavf: fix off-by-one issues in iavf_config_rss_reg()
      CVE-2025-71091: team: fix check for port enabled in team_queue_overri=
de_port_prio_changed()
      CVE-2025-71093: e1000: fix OOB in e1000_tbi_should_accept()
      CVE-2025-71096: RDMA/core: Check for the presence of LS_NLA_TYPE_DGID=
 correctly
      CVE-2025-71097: ipv4: Fix reference count leak when using error route=
s with nexthop objects
      CVE-2025-71098: ip6_gre: make ip6gre_header() robust
      CVE-2025-71102: scs: fix a wrong parameter in __scs_magic
      CVE-2025-71104: KVM: x86: Fix VM hard lockup after prolonged inactivi=
ty with periodic HV timer
      CVE-2025-71105: f2fs: use global inline_xattr_slab instead of per-sb =
slab cache
      CVE-2025-71108: usb: typec: ucsi: Handle incorrect num_connectors cap=
ability
      CVE-2025-71111: hwmon: (w83791d) Convert macros to functions to avoid=
 TOCTOU
      CVE-2025-71112: net: hns3: add VLAN id validation before using
      CVE-2025-71113: crypto: af_alg - zero initialize memory allocated via=
 sock_kmalloc
      CVE-2025-71114: via_wdt: fix critical boot hang due to unnamed resour=
ce allocation
      CVE-2025-71116: libceph: make decode_pool() more resilient against co=
rrupted osdmaps
      CVE-2025-71118: ACPICA: Avoid walking the Namespace if start_node is =
NULL
      CVE-2025-71120: SUNRPC: svcauth_gss: avoid NULL deref on zero length =
gss_token in gss_read_proxy_verf
      CVE-2025-71121: parisc: Do not reprogram affinitiy on ASP chip
      CVE-2025-71123: ext4: fix string copying in parse_apply_sb_mount_opti=
ons()
      CVE-2025-71125: tracing: Do not register unsupported perf events
      CVE-2025-71127: wifi: mac80211: Discard Beacon frames to non-broadcas=
t address
      CVE-2025-71131: crypto: seqiv - Do not use req->iv after crypto_aead_=
encrypt
      CVE-2025-71136: media: adv7842: Avoid possible out-of-bounds array ac=
cesses in adv7842_cp_log_status()
      CVE-2025-71137: octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
      CVE-2025-71146: netfilter: nf_conncount: fix leaked ct in error paths
      CVE-2025-71154: net: usb: rtl8150: fix memory leak on usb_submit_urb(=
) failure
      CVE-2025-71182: can: j1939: make j1939_session_activate() fail if dev=
ice is no longer registered
      CVE-2026-22976: net/sched: sch_qfq: Fix NULL deref when deactivating =
inactive aggregate in qfq_reset
      CVE-2026-22977: net: sock: fix hardened usercopy panic in sock_recv_e=
rrqueue
      CVE-2026-22978: wifi: avoid kernel-infoleak from struct iw_point
      CVE-2026-22980: nfsd: provide locking for v4_end_grace
      CVE-2026-22988: arp: do not assume dev_hard_header() does not change =
skb->head
      CVE-2026-22990: libceph: replace overzealous BUG_ON in osdmap_apply_i=
ncremental()
      CVE-2026-22991: libceph: make free_choose_arg_map() resilient to part=
ial allocation
      CVE-2026-23020: net: 3com: 3c59x: fix possible null dereference in vo=
rtex_probe1()
      CVE-2026-23021: net: usb: pegasus: fix memory leak in update_eth_regs=
_async()
      CVE-2026-23047: libceph: make calc_target() set t->paused, not just c=
lear it
      CVE-2022-3526: macvlan: Fix leaking skb in source mode with nodst opt=
ion
      CVE-2022-50404: fbdev: fbcon: release buffer when fbcon_do_set_font()=
 failed
      CVE-2023-54207: HID: uclogic: Correct devm device reference for hidin=
put input_dev name
      CVE-2023-54321: driver core: fix potential null-ptr-deref in device_a=
dd()
      CVE-2024-26655: Fix memory leak in posix_clock_open()
      CVE-2024-26798: fbcon: always restore the old font data in fbcon_do_s=
et_font()
      CVE-2025-38007: HID: uclogic: Add NULL check in uclogic_input_configu=
red()
      CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields
      CVE-2025-39702: ipv6: sr: Fix MAC comparison to be constant-time
      CVE-2025-68211: ksm: use range-walk function to jump over holes in sc=
an_get_next_rmap_item
      CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types=
 to stack
      CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free
      CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335=
x route allocation
      CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route al=
location
      CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route a=
llocation
      CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe
      CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate(=
)
      CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to ig=
nored transaction type
      CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()
      CVE-2025-71197: w1: therm: Fix off-by-one buffer overflow in alarms_s=
tore
      CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential use-after-f=
ree in sama5d2_adc driver
      CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active(): d=
eactivate session upon receiving the second rts
      CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_=
build_pdu_iovec
      CVE-2026-22999: net/sched: sch_qfq: do not free existing class in qfq=
_change_class()
      CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()
      CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_=
rcv()
      CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust
      CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in er=
ror paths
      CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_devi=
ceid_node()
      CVE-2026-23049: drm/panel-simple: fix connector type for DataImage SC=
F0700C48GGU18 panel
      CVE-2026-23056: uacce: implement mremap in uacce_vm_ops to return -EP=
ERM
      CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8=
) to match ESP/ESN spec
      CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix=
 URB memory leak
      CVE-2026-23063: uacce: ensure safe queue release with state managemen=
t
      CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref
      CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave rout=
ine
      CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif d=
river data size
      CVE-2026-23074: net/sched: Enforce that teql can only be used as root=
 qdisc
      CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer =
handling
      CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23083: fou: Don't allow 0 for FOU_ATTR_IPPROTO.
      CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_ma=
c_from_list
      CVE-2026-23085: irqchip/gic-v3-its: Avoid truncating memory addresses
      CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in scs=
iback_remove()
      CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_=
free()
      CVE-2026-23090: slimbus: core: fix device reference leak on report pr=
esent
      CVE-2026-23091: intel_th: fix device leak on output open()
      CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.
      CVE-2026-23096: uacce: fix cdev handling in the cleanup path
      CVE-2026-23097: migrate: correct lock ordering for hugetlb file folio=
s
      CVE-2026-23098: netrom: fix double-free in nr_route_frame()
      CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is=
 fully ready
      CVE-2026-23103: ipvlan: Make the addrs_lock be per port
      CVE-2026-23105: net/sched: qfq: Use cl_is_active to determine whether=
 class is active in qfq_rm_from_ag
      CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23110: scsi: core: Wake up the error handler when final comp=
letions race against each other
    added commits:
      CIP: Bump version suffix to -cip69 after merge from stable
      thermal/drivers/renesas/rzg3s: Fix inverted reset logic in devm clean=
up
      mmc: renesas_sdhi: Add suspend/resume hooks
      mmc: renesas_sdhi: Deassert the reset signal on probe
      clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
      clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
      clk: renesas: r9a08g045: Add MSTOP for GPIO
      clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
      clk: renesas: r9a08g045: Drop power domain instantiation
      clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable AP=
I
      clk: renesas: rzg2l: Add macro to loop through module clocks
      clk: renesas: rzg2l: Move pointers after hw member
      clk: renesas: rzg2l: Postpone updating priv->clks[]
      clk: renesas: rzg2l: Extend power domain support
      i2c: core: Drop dev_pm_domain_detach() call
      spi: Drop dev_pm_domain_detach() call
      mmc: sdio: Drop dev_pm_domain_detach() call
      driver core: platform: Drop dev_pm_domain_detach() call
      PM: domains: Detach on device_unbind_cleanup()
      PM: domains: Add helper to check for PM domain detach on unbind clean=
up
      of: Add of_machine_compatible_match()
      PM: domains: Add flags to specify power on attach/detach
      pinctrl: renesas: rzg2l: Fix ISEL restore on resume

  v6.1.162-cip51:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      2bdddbb7e29cb5f8500678b21332131e06e176bf
    fixed CVEs:
      CVE-2024-40928: net: ethtool: fix the error condition in ethtool_get_=
phy_stats_ethtool()
      CVE-2024-46786: fscache: delete fscache_cookie_lru_timer when fscache=
 exits to avoid UAF
      CVE-2024-49968: ext4: filesystems without casefold feature cannot be =
mounted with siphash
      CVE-2024-50081: blk-mq: setup queue ->tag_set before initializing hct=
x
      CVE-2025-21946: ksmbd: fix out-of-bounds in parse_sec_desc()
      CVE-2025-22022: usb: xhci: Apply the link chain quirk on NEC isoc end=
points
      CVE-2025-22090: x86/mm/pat: Fix VM_PAT handling when fork() fails in =
copy_page_range()
      CVE-2025-22107: net: dsa: sja1105: fix kasan out-of-bounds warning in=
 sja1105_table_delete_entry()
      CVE-2025-22111: net: Remove RTNL dance for SIOCBRADDIF and SIOCBRDELI=
F.
      CVE-2025-37835: [REJECTED]: hwmon: (ibmpex) fix use-after-free in hig=
h/low store
      CVE-2025-38022: RDMA/core: Fix "KASAN: slab-use-after-free Read in ib=
_register_device" problem
      CVE-2025-38129: page_pool: Fix use-after-free in page_pool_recycle_in=
_ring
      CVE-2025-39871: dmaengine: idxd: Remove improper idxd_free
      CVE-2025-40110: drm/vmwgfx: Fix a null-ptr access in the cursor snoop=
er
      CVE-2025-40215: xfrm: delete x->tunnel as we delete x
      CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy t=
ime for states that were never added
      CVE-2025-68254: staging: rtl8723bs: fix out-of-bounds read in OnBeaco=
n ESR IE parsing
      CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in OnAs=
socReq IE parsing
      CVE-2025-68256: staging: rtl8723bs: fix out-of-bounds read in rtw_get=
_ie() parser
      CVE-2025-68257: comedi: check device's attached status in compat ioct=
ls
      CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_a=
ttach()
      CVE-2025-68259: KVM: SVM: Don't skip unrelated instruction if INT3/IN=
TO is replaced
      CVE-2025-68261: ext4: add i_data_sem protection in ext4_destroy_inlin=
e_data_nolock()
      CVE-2025-68263: ksmbd: ipc: fix use-after-free in ipc_msg_send_reques=
t
      CVE-2025-68264: ext4: refresh inline data size before write operation=
s
      CVE-2025-68266: bfs: Reconstruct file type when loading from disk
      CVE-2025-68291: mptcp: Initialise rcv_mss before calling tcp_send_act=
ive_reset() in mptcp_do_fastclose().
      CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in =
cake_drop
      CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistrati=
on
      CVE-2025-68335: comedi: pcl818: fix null-ptr-deref in pcl818_ai_cance=
l()
      CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write=
_lock
      CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access(=
) when file system corrupted
      CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size =
validation
      CVE-2025-68345: ALSA: hda: cs35l41: Fix NULL pointer dereference in c=
s35l41_hda_read_acpi()
      CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_form=
ats()
      CVE-2025-68347: ALSA: firewire-motu: fix buffer overflow in hwdep rea=
d for DSP events
      CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_l=
ayout_stateid_invalid
      CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list =
with regulator_list_mutex
      CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflo=
w in rtl8187_rx_cb()
      CVE-2025-68363: bpf: Check skb->transport_header is set in bpf_skb_ch=
eck_mtu
      CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_e=
xtent()
      CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect
      CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_togg=
le_emumouse
      CVE-2025-68369: ntfs3: init run lock for extend inode
      CVE-2025-68371: scsi: smartpqi: Fix device resources accessed after d=
evice removal
      CVE-2025-68372: nbd: defer config put in recv_work
      CVE-2025-68380: wifi: ath11k: fix peer HE MCS assignment
      CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in asymmet=
ric_key_generate_id
      CVE-2025-68727: ntfs3: Fix uninit buffer allocated by __getname()
      CVE-2025-68728: ntfs3: fix uninit memory after failed mi_read in mi_f=
ormat_new
      CVE-2025-68732: gpu: host1x: Fix race in syncpt alloc/free
      CVE-2025-68733: smack: fix bug: unprivileged task can create labels
      CVE-2025-68740: ima: Handle error code returned by ima_filter_rule_ma=
tch()
      CVE-2025-68742: bpf: Fix invalid prog->stats access when update_effec=
tive_progs fails
      CVE-2025-68746: spi: tegra210-quad: Fix timeout handling
      CVE-2025-68753: ALSA: firewire-motu: add bounds check in put_user loo=
p for DSP events
      CVE-2025-68757: drm/vgem-fence: Fix potential deadlock on release
      CVE-2025-68758: backlight: led-bl: Add devlink to supplier LEDs
      CVE-2025-68759: wifi: rtl818x: Fix potential memory leaks in rtl8180_=
init_rx_ring()
      CVE-2025-68764: NFS: Automounted filesystems should inherit ro,noexec=
,nodev,sync flags
      CVE-2025-68765: mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_=
add()
      CVE-2025-68766: irqchip/mchp-eic: Fix error code in mchp_eic_domain_a=
lloc()
      CVE-2025-68767: hfsplus: Verify inode mode when loading from disk
      CVE-2025-68769: f2fs: fix return value of f2fs_recover_fsync_data()
      CVE-2025-68771: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
      CVE-2025-68772: f2fs: fix to avoid updating compression context durin=
g writeback
      CVE-2025-68773: spi: fsl-cpm: Check length parity before switching to=
 16 bit mode
      CVE-2025-68774: hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_c=
reate
      CVE-2025-68776: net/hsr: fix NULL pointer dereference in prp_get_unta=
gged_frame()
      CVE-2025-68777: Input: ti_am335x_tsc - fix off-by-one error in wire_o=
rder validation
      CVE-2025-68778: btrfs: don't log conflicting inode if it's a dir move=
d in the current transaction
      CVE-2025-68780: sched/deadline: only set free_cpus for online runqueu=
es
      CVE-2025-68781: usb: phy: fsl-usb: Fix use-after-free in delayed work=
 during device removal
      CVE-2025-68782: scsi: target: Reset t_task_cdb pointer in error case
      CVE-2025-68783: ALSA: usb-mixer: us16x08: validate meter packet indic=
es
      CVE-2025-68785: net: openvswitch: fix middle attribute validation in =
push_nsh() action
      CVE-2025-68786: ksmbd: skip lock-range check on equal size to avoid s=
ize=3D=3D0 underflow
      CVE-2025-68787: netrom: Fix memory leak in nr_sendmsg()
      CVE-2025-68788: fsnotify: do not generate ACCESS/MODIFY events on chi=
ld for special files
      CVE-2025-68789: [REJECTED]: hwmon: (ibmpex) fix use-after-free in hig=
h/low store
      CVE-2025-68795: ethtool: Avoid overflowing userspace buffer on stats =
query
      CVE-2025-68796: f2fs: fix to avoid updating zero-sized extent in exte=
nt cache
      CVE-2025-68797: char: applicom: fix NULL pointer dereference in ac_io=
ctl
      CVE-2025-68798: perf/x86/amd: Check event before enable to avoid GPF
      CVE-2025-68799: caif: fix integer underflow in cffrml_receive()
      CVE-2025-68800: mlxsw: spectrum_mr: Fix use-after-free when updating =
multicast route stats
      CVE-2025-68801: mlxsw: spectrum_router: Fix neighbour use-after-free
      CVE-2025-68803: NFSD: NFSv4 file creation neglects setting ACL
      CVE-2025-68804: platform/chrome: cros_ec_ishtp: Fix UAF after unbindi=
ng driver
      CVE-2025-68806: ksmbd: fix buffer validation by including null termin=
ator size in EA length
      CVE-2025-68808: media: vidtv: initialize local pointers upon transfer=
 of memory ownership
      CVE-2025-68813: ipvs: fix ipv4 null-ptr-deref in route error path
      CVE-2025-68814: io_uring: fix filename leak in __io_openat_prep()
      CVE-2025-68815: net/sched: ets: Remove drr class from the active list=
 if it changes to strict
      CVE-2025-68816: net/mlx5: fw_tracer, Validate format string parameter=
s
      CVE-2025-68817: ksmbd: fix use-after-free in ksmbd_tree_connect_put u=
nder concurrency
      CVE-2025-68818: scsi: Revert "scsi: qla2xxx: Perform lockless command=
 completion in abort path"
      CVE-2025-68819: media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100=
_i2c_msg()
      CVE-2025-68820: ext4: xattr: fix null pointer deref in ext4_raw_inode=
()
      CVE-2025-68821: fuse: fix readahead reclaim deadlock
      CVE-2025-71064: net: hns3: using the num_tqps in the vf driver to app=
ly for resources
      CVE-2025-71066: net/sched: ets: Always remove class from active list =
before deleting in ets_qdisc_change
      CVE-2025-71069: f2fs: invalidate dentry cache on failed whiteout crea=
tion
      CVE-2025-71071: iommu/mediatek: fix use-after-free on probe deferral
      CVE-2025-71075: scsi: aic94xx: fix use-after-free in device removal p=
ath
      CVE-2025-71077: tpm: Cap the number of PCR banks
      CVE-2025-71078: powerpc/64s/slb: Fix SLB multihit issue during SLB pr=
eload
      CVE-2025-71079: net: nfc: fix deadlock between nfc_unregister_device =
and rfkill_fop_write
      CVE-2025-71081: ASoC: stm32: sai: fix OF node leak on probe
      CVE-2025-71082: Bluetooth: btusb: revert use of devm_kzalloc in btusb
      CVE-2025-71083: drm/ttm: Avoid NULL pointer deref for evicted BOs
      CVE-2025-71084: RDMA/cm: Fix leaking the multicast GID table referenc=
e
      CVE-2025-71085: ipv6: BUG() in pskb_expand_head() as part of calipso_=
skbuff_setattr()
      CVE-2025-71086: net: rose: fix invalid array index in rose_kill_by_de=
vice()
      CVE-2025-71087: iavf: fix off-by-one issues in iavf_config_rss_reg()
      CVE-2025-71088: mptcp: fallback earlier on simult connection
      CVE-2025-71091: team: fix check for port enabled in team_queue_overri=
de_port_prio_changed()
      CVE-2025-71093: e1000: fix OOB in e1000_tbi_should_accept()
      CVE-2025-71094: net: usb: asix: validate PHY address before use
      CVE-2025-71095: net: stmmac: fix the crash issue for zero copy XDP_TX=
 action
      CVE-2025-71096: RDMA/core: Check for the presence of LS_NLA_TYPE_DGID=
 correctly
      CVE-2025-71097: ipv4: Fix reference count leak when using error route=
s with nexthop objects
      CVE-2025-71098: ip6_gre: make ip6gre_header() robust
      CVE-2025-71102: scs: fix a wrong parameter in __scs_magic
      CVE-2025-71104: KVM: x86: Fix VM hard lockup after prolonged inactivi=
ty with periodic HV timer
      CVE-2025-71105: f2fs: use global inline_xattr_slab instead of per-sb =
slab cache
      CVE-2025-71108: usb: typec: ucsi: Handle incorrect num_connectors cap=
ability
      CVE-2025-71111: hwmon: (w83791d) Convert macros to functions to avoid=
 TOCTOU
      CVE-2025-71112: net: hns3: add VLAN id validation before using
      CVE-2025-71113: crypto: af_alg - zero initialize memory allocated via=
 sock_kmalloc
      CVE-2025-71114: via_wdt: fix critical boot hang due to unnamed resour=
ce allocation
      CVE-2025-71116: libceph: make decode_pool() more resilient against co=
rrupted osdmaps
      CVE-2025-71118: ACPICA: Avoid walking the Namespace if start_node is =
NULL
      CVE-2025-71119: powerpc/kexec: Enable SMT before waking offline CPUs
      CVE-2025-71120: SUNRPC: svcauth_gss: avoid NULL deref on zero length =
gss_token in gss_read_proxy_verf
      CVE-2025-71121: parisc: Do not reprogram affinitiy on ASP chip
      CVE-2025-71123: ext4: fix string copying in parse_apply_sb_mount_opti=
ons()
      CVE-2025-71125: tracing: Do not register unsupported perf events
      CVE-2025-71126: mptcp: avoid deadlock on fallback while reinjecting
      CVE-2025-71127: wifi: mac80211: Discard Beacon frames to non-broadcas=
t address
      CVE-2025-71130: drm/i915/gem: Zero-initialize the eb.vma array in i91=
5_gem_do_execbuffer
      CVE-2025-71131: crypto: seqiv - Do not use req->iv after crypto_aead_=
encrypt
      CVE-2025-71132: smc91x: fix broken irq-context in PREEMPT_RT
      CVE-2025-71133: RDMA/irdma: avoid invalid read in irdma_net_event
      CVE-2025-71136: media: adv7842: Avoid possible out-of-bounds array ac=
cesses in adv7842_cp_log_status()
      CVE-2025-71137: octeontx2-pf: fix "UBSAN: shift-out-of-bounds error"
      CVE-2025-71145: usb: phy: isp1301: fix non-OF device reference imbala=
nce
      CVE-2025-71146: netfilter: nf_conncount: fix leaked ct in error paths
      CVE-2025-71147: KEYS: trusted: Fix a memory leak in tpm2_load_cmd
      CVE-2025-71149: io_uring/poll: correctly handle io_poll_add() return =
value on update
      CVE-2025-71150: ksmbd: Fix refcount leak when invalid session is foun=
d on session lookup
      CVE-2025-71154: net: usb: rtl8150: fix memory leak on usb_submit_urb(=
) failure
      CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_r=
ef_all()
      CVE-2025-40149: tls: Use __sk_dst_get() and dst_dev_rcu() in get_netd=
ev_for_sock().
      CVE-2025-68211: ksm: use range-walk function to jump over holes in sc=
an_get_next_rmap_item
      CVE-2025-71180: counter: interrupt-cnt: Drop IRQF_NO_THREAD flag
      CVE-2025-71182: can: j1939: make j1939_session_activate() fail if dev=
ice is no longer registered
      CVE-2025-71183: btrfs: always detect conflicting inodes when logging =
inode refs
      CVE-2025-71192: ALSA: ac97: fix a double free in snd_ac97_controller_=
register()
      CVE-2026-22976: net/sched: sch_qfq: Fix NULL deref when deactivating =
inactive aggregate in qfq_reset
      CVE-2026-22977: net: sock: fix hardened usercopy panic in sock_recv_e=
rrqueue
      CVE-2026-22978: wifi: avoid kernel-infoleak from struct iw_point
      CVE-2026-22979: net: fix memory leak in skb_segment_list for GRO pack=
ets
      CVE-2026-22980: nfsd: provide locking for v4_end_grace
      CVE-2026-22982: net: mscc: ocelot: Fix crash when adding interface un=
der a lag
      CVE-2026-22984: libceph: prevent potential out-of-bounds reads in han=
dle_auth_done()
      CVE-2026-22988: arp: do not assume dev_hard_header() does not change =
skb->head
      CVE-2026-22990: libceph: replace overzealous BUG_ON in osdmap_apply_i=
ncremental()
      CVE-2026-22991: libceph: make free_choose_arg_map() resilient to part=
ial allocation
      CVE-2026-22992: libceph: return the handler error from mon_handle_aut=
h_done()
      CVE-2026-22994: bpf: Fix reference count leak in bpf_prog_test_run_xd=
p()
      CVE-2026-23019: net: marvell: prestera: fix NULL dereference on devli=
nk_alloc() failure
      CVE-2026-23020: net: 3com: 3c59x: fix possible null dereference in vo=
rtex_probe1()
      CVE-2026-23021: net: usb: pegasus: fix memory leak in update_eth_regs=
_async()
      CVE-2026-23047: libceph: make calc_target() set t->paused, not just c=
lear it
      CVE-2023-52658: Revert "net/mlx5: Block entering switchdev mode with =
ns inconsistency"
      CVE-2023-53421: blk-cgroup: Reinit blkg_iostat_set after clearing in =
blkcg_reset_stats()
      CVE-2023-54285: iomap: Fix possible overflow condition in iomap_write=
_delalloc_scan
      CVE-2024-26655: Fix memory leak in posix_clock_open()
      CVE-2024-42079: gfs2: Fix NULL pointer dereference in gfs2_log_flush
      CVE-2025-22083: vhost-scsi: Fix handling of multiple calls to vhost_s=
csi_set_endpoint
      CVE-2025-37926: ksmbd: fix use-after-free in ksmbd_session_rpc_open
      CVE-2025-38104: drm/amdgpu: Replace Mutex with Spinlock for RLCG regi=
ster access to avoid Priority Inversion in SRIOV
      CVE-2025-38125: net: stmmac: make sure that ptp_rate is not 0 before =
configuring EST
      CVE-2025-38232: NFSD: fix race between nfsd registration and exports_=
proc
      CVE-2025-38361: drm/amd/display: Check dce_hwseq before dereferencing=
 it
      CVE-2025-38408: genirq/irq_sim: Initialize work context pointers prop=
erly
      CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields
      CVE-2025-38718: sctp: linearize cloned gso packets in sctp_rcv
      CVE-2025-39721: crypto: qat - flush misc workqueue during device shut=
down
      CVE-2025-40039: ksmbd: Fix race condition in RPC handle list access
      CVE-2025-40090: ksmbd: fix recursive locking in RPC handle list acces=
s
      CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible c=
ode warnings
      CVE-2025-68223: drm/radeon: delete radeon_fence_process in is_signale=
d, no deadlock
      CVE-2025-68340: team: Move team device type change at the end of team=
_port_add
      CVE-2025-68365: fs/ntfs3: Initialize allocated memory before use
      CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types=
 to stack
      CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free
      CVE-2025-71163: dmaengine: idxd: fix device leaks on compat bind and =
unbind
      CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335=
x route allocation
      CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route al=
location
      CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route a=
llocation
      CVE-2025-71189: dmaengine: dw: dmamux: fix OF node leak on route allo=
cation failure
      CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe
      CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate(=
)
      CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to ig=
nored transaction type
      CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()
      CVE-2025-71197: w1: therm: Fix off-by-one buffer overflow in alarms_s=
tore
      CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential use-after-f=
ree in sama5d2_adc driver
      CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active(): d=
eactivate session upon receiving the second rts
      CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_=
build_pdu_iovec
      CVE-2026-22999: net/sched: sch_qfq: do not free existing class in qfq=
_change_class()
      CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()
      CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_=
rcv()
      CVE-2026-23005: x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state when=
ever XFD[i]=3D1
      CVE-2026-23006: ASoC: tlv320adcx140: fix null pointer
      CVE-2026-23010: ipv6: Fix use-after-free in inet6_addr_del().
      CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust
      CVE-2026-23025: mm/page_alloc: prevent pcp corruption with SMP=3Dn
      CVE-2026-23026: dmaengine: qcom: gpi: Fix memory leak in gpi_peripher=
al_config()
      CVE-2026-23030: phy: rockchip: inno-usb2: Fix a double free bug in ro=
ckchip_usb2phy_probe()
      CVE-2026-23031: can: gs_usb: gs_usb_receive_bulk_callback(): fix URB =
memory leak
      CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in er=
ror paths
      CVE-2026-23037: can: etas_es58x: allow partial RX URB allocation to s=
ucceed
      CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_devi=
ceid_node()
      CVE-2026-23049: drm/panel-simple: fix connector type for DataImage SC=
F0700C48GGU18 panel
      CVE-2026-23054: net: hv_netvsc: reject RSS hash key programming witho=
ut RX indirection table
      CVE-2026-23056: uacce: implement mremap in uacce_vm_ops to return -EP=
ERM
      CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8=
) to match ESP/ESN spec
      CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix=
 URB memory leak
      CVE-2026-23063: uacce: ensure safe queue release with state managemen=
t
      CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref
      CVE-2026-23068: spi: spi-sprd-adi: Fix double free in probe error pat=
h
      CVE-2026-23069: vsock/virtio: fix potential underflow in virtio_trans=
port_get_credit()
      CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave rout=
ine
      CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif d=
river data size
      CVE-2026-23074: net/sched: Enforce that teql can only be used as root=
 qdisc
      CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer =
handling
      CVE-2026-23078: ALSA: scarlett2: Fix buffer overflow in config retrie=
val
      CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23082: can: gs_usb: gs_usb_receive_bulk_callback(): unanchor=
 URL on usb_submit_urb() error
      CVE-2026-23083: fou: Don't allow 0 for FOU_ATTR_IPPROTO.
      CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_ma=
c_from_list
      CVE-2026-23085: irqchip/gic-v3-its: Avoid truncating memory addresses
      CVE-2026-23086: vsock/virtio: cap TX credit to local buffer size
      CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in scs=
iback_remove()
      CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_=
free()
      CVE-2026-23090: slimbus: core: fix device reference leak on report pr=
esent
      CVE-2026-23091: intel_th: fix device leak on output open()
      CVE-2026-23093: ksmbd: smbd: fix dma_unmap_sg() nents
      CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.
      CVE-2026-23096: uacce: fix cdev handling in the cleanup path
      CVE-2026-23097: migrate: correct lock ordering for hugetlb file folio=
s
      CVE-2026-23098: netrom: fix double-free in nr_route_frame()
      CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices
      CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is=
 fully ready
      CVE-2026-23102: arm64/fpsimd: signal: Fix restoration of SVE context
      CVE-2026-23103: ipvlan: Make the addrs_lock be per port
      CVE-2026-23105: net/sched: qfq: Use cl_is_active to determine whether=
 class is active in qfq_rm_from_ag
      CVE-2026-23107: arm64/fpsimd: signal: Allocate SSVE storage when rest=
oring ZA
      CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23110: scsi: core: Wake up the error handler when final comp=
letions race against each other
    added commits:
      CIP: Bump version suffix to -cip51 after merge from stable
      arm64: dts: renesas: r9a09g047: Add TSU node
      PM: domains: Add RZ/G3E compatible to PM domain detach list
      arm64: dts: renesas: r9a09g047: Move interrupt-parent to root node
      arm64: dts: renesas: r9a09g047: Add DMAC nodes
      dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
      clk: renesas: r9a09g047: Add DMAC clocks and resets
      thermal/drivers/renesas/rzg3s: Fix inverted reset logic in devm clean=
up
      arm64: dts: renesas: r9a09g057: Add TSU nodes
      arm64: dts: renesas: r9a09g057: Move interrupt-parent to root node
      clk: renesas: r9a09g057: Add clock and reset entries for TSU
      arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
      thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas=
 RZ/G3E SoC
      thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/=
G3E SoC
      dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
      PM: domains: Add RZ/V2H compatible to PM domain detach list
      soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap =
config
      soc: renesas: r9a09g056-sys: Populate max_register
      soc: renesas: rz-sysc: Add syscon/regmap support
      mmc: renesas_sdhi: Add suspend/resume hooks
      mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() a=
nd pm_ptr()
      mmc: renesas_sdhi: Deassert the reset signal on probe
      clk: renesas: r9a07g043: Add MSTOP for RZ/G2UL
      clk: renesas: r9a07g044: Add MSTOP for RZ/G2L
      clk: renesas: r9a08g045: Add MSTOP for GPIO
      clk: renesas: r9a08g045: Add MSTOP for coupled clocks as well
      clk: renesas: r9a08g045: Drop power domain instantiation
      clk: renesas: rzg2l: Add support for MSTOP in clock enable/disable AP=
I
      clk: renesas: rzg2l: Add macro to loop through module clocks
      clk: renesas: rzg2l: Move pointers after hw member
      clk: renesas: rzg2l: Postpone updating priv->clks[]
      clk: renesas: rzg2l: Extend power domain support
      i2c: core: Drop dev_pm_domain_detach() call
      driver core: auxiliary bus: Drop dev_pm_domain_detach() call
      spi: Drop dev_pm_domain_detach() call
      mmc: sdio: Drop dev_pm_domain_detach() call
      driver core: platform: Drop dev_pm_domain_detach() call
      PM: domains: Detach on device_unbind_cleanup()
      PM: domains: Add helper to check for PM domain detach on unbind clean=
up
      of: Add of_machine_compatible_match()
      PM: domains: Add flags to specify power on attach/detach
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable serial NOR FLASH
      arm64: dts: renesas: r9a09g056: Add XSPI node
      clk: renesas: r9a09g056: Add XSPI clock/reset
      clk: renesas: r9a09g056: Add support for xspi mux and divider
      dt-bindings: clock: renesas,r9a09g056/57-cpg: Add XSPI core clock
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable USB2.0 support
      arm64: dts: renesas: r9a09g056: Add USB2.0 support
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2N SoC support
      dt-bindings: usb: renesas,usbhs: Add RZ/V2N SoC support
      dt-bindings: reset: renesas,rzv2h-usb2phy: Document RZ/V2N SoC suppor=
t
      clk: renesas: r9a09g056: Add clock and reset entries for USB2.0
      arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RIIC controllers
      arm64: dts: renesas: r9a09g056: Add RIIC controllers
      dt-bindings: i2c: renesas,riic: Document RZ/V2N (R9A09G056) support
      clk: renesas: r9a09g056: Add clock and reset entries for RIIC control=
lers
      arm64: dts: renesas: r9a09g047: Add I3C node
      clk: renesas: r9a09g047: Add I3C0 clocks and resets
      i3c: export SETDASA method
      i3c: Correct the macro module_i3c_i2c_driver
      i3c: master: Add inline i3c_readl_fifo() and i3c_writel_fifo()
      i3c: document i3c_xfers
      i3c: master: Add helpers for DMA mapping and bounce buffer handling
      i3c: Add more parameters for controllers to the header
      i3c: Standardize defines for specification parameters
      i3c: Remove the const qualifier from i2c_msg pointer in i2c_xfers API
      i3c: Document I3C_ADDR_SLOT_EXT_STATUS_MASK
      i3c: master: Add basic driver for the Renesas I3C controller
      i3c: controllers do not need to depend on I3C
      dt-bindings: i3c: Add Renesas I3C controller
      bitops: add generic parity calculation for u8
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Add NMI pushbutton suppo=
rt
      arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable RTC
      arm64: dts: renesas: r9a09g057: Add RTC node
      rtc: renesas-rtca3: Add support for multiple reset lines
      rtc: renesas-rtca3: stop setting max_user_freq
      rtc: renesas-rtca3: Disable interrupts only if the RTC is enabled
      clk: renesas: r9a09g057: Add clock and reset entries for RTC
      dt-bindings: rtc: renesas,rz-rtca3: Add RZ/V2H support

  v6.12.69-cip17:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.12.y-cip
    commit hash:
      ecbde0dc33194f21f119b0fd1d74158d22ac5b74
    fixed CVEs:
      CVE-2025-38248: bridge: mcast: Fix use-after-free during router port =
configuration
      CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields
      CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free
      CVE-2025-71163: dmaengine: idxd: fix device leaks on compat bind and =
unbind
      CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335=
x route allocation
      CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route al=
location
      CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route a=
llocation
      CVE-2025-71189: dmaengine: dw: dmamux: fix OF node leak on route allo=
cation failure
      CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe
      CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate(=
)
      CVE-2025-71193: phy: qcom-qusb2: Fix NULL pointer dereference on earl=
y suspend
      CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to ig=
nored transaction type
      CVE-2025-71195: dmaengine: xilinx: xdma: Fix regmap max_register
      CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()
      CVE-2026-22996: net/mlx5e: Don't store mlx5e_priv in mlx5e_dev devlin=
k priv
      CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active(): d=
eactivate session upon receiving the second rts
      CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in nvmet_tcp_=
build_pdu_iovec
      CVE-2026-22999: net/sched: sch_qfq: do not free existing class in qfq=
_change_class()
      CVE-2026-23000: net/mlx5e: Fix crash on profile change rollback failu=
re
      CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()
      CVE-2026-23002: lib/buildid: use __kernel_read() for sleepable contex=
t
      CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_=
rcv()
      CVE-2026-23005: x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state when=
ever XFD[i]=3D1
      CVE-2026-23006: ASoC: tlv320adcx140: fix null pointer
      CVE-2026-23010: ipv6: Fix use-after-free in inet6_addr_del().
      CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust
      CVE-2026-23013: net: octeon_ep_vf: fix free_irq dev_id mismatch in IR=
Q rollback
      CVE-2026-23025: mm/page_alloc: prevent pcp corruption with SMP=3Dn
      CVE-2026-23026: dmaengine: qcom: gpi: Fix memory leak in gpi_peripher=
al_config()
      CVE-2026-23030: phy: rockchip: inno-usb2: Fix a double free bug in ro=
ckchip_usb2phy_probe()
      CVE-2026-23031: can: gs_usb: gs_usb_receive_bulk_callback(): fix URB =
memory leak
      CVE-2026-23032: null_blk: fix kmemleak by releasing references to fau=
lt configfs items
      CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in er=
ror paths
      CVE-2026-23035: net/mlx5e: Pass netdev to mlx5e_destroy_netdev instea=
d of priv
      CVE-2026-23037: can: etas_es58x: allow partial RX URB allocation to s=
ucceed
      CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_devi=
ceid_node()
      CVE-2026-23049: drm/panel-simple: fix connector type for DataImage SC=
F0700C48GGU18 panel
      CVE-2026-23050: pNFS: Fix a deadlock when returning a delegation duri=
ng open()
      CVE-2026-23053: NFS: Fix a deadlock involving nfs_release_folio()
      CVE-2026-23054: net: hv_netvsc: reject RSS hash key programming witho=
ut RX indirection table
      CVE-2026-23055: i2c: riic: Move suspend handling to NOIRQ phase
      CVE-2024-58097: wifi: ath11k: fix RCU stall while reaping monitor des=
tination ring
      CVE-2025-68333: sched_ext: Fix possible deadlock in the deferred_irq_=
workfn()
      CVE-2025-68351: exfat: fix refcount leak in exfat_find
      CVE-2025-68358: btrfs: fix racy bitfield write in btrfs_clear_space_i=
nfo_full()
      CVE-2025-68365: fs/ntfs3: Initialize allocated memory before use
      CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types=
 to stack
      CVE-2025-68749: accel/ivpu: Fix race condition when unbinding BOs
      CVE-2025-71197: w1: therm: Fix off-by-one buffer overflow in alarms_s=
tore
      CVE-2025-71198: iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors w=
ithout event detection
      CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential use-after-f=
ree in sama5d2_adc driver
      CVE-2026-23056: uacce: implement mremap in uacce_vm_ops to return -EP=
ERM
      CVE-2026-23057: vsock/virtio: Coalesce only linear skb
      CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23059: scsi: qla2xxx: Sanitize payload size to prevent membe=
r overflow
      CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8=
) to match ESP/ESN spec
      CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix=
 URB memory leak
      CVE-2026-23062: platform/x86: hp-bioscfg: Fix kernel panic in GET_INS=
TANCE_ID macro
      CVE-2026-23063: uacce: ensure safe queue release with state managemen=
t
      CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref
      CVE-2026-23065: platform/x86/amd: Fix memory leak in wbrf_record()
      CVE-2026-23068: spi: spi-sprd-adi: Fix double free in probe error pat=
h
      CVE-2026-23069: vsock/virtio: fix potential underflow in virtio_trans=
port_get_credit()
      CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave rout=
ine
      CVE-2026-23072: l2tp: Fix memleak in l2tp_udp_encap_recv().
      CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif d=
river data size
      CVE-2026-23074: net/sched: Enforce that teql can only be used as root=
 qdisc
      CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB m=
emory leak
      CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer =
handling
      CVE-2026-23078: ALSA: scarlett2: Fix buffer overflow in config retrie=
val
      CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23082: can: gs_usb: gs_usb_receive_bulk_callback(): unanchor=
 URL on usb_submit_urb() error
      CVE-2026-23083: fou: Don't allow 0 for FOU_ATTR_IPPROTO.
      CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_ma=
c_from_list
      CVE-2026-23085: irqchip/gic-v3-its: Avoid truncating memory addresses
      CVE-2026-23086: vsock/virtio: cap TX credit to local buffer size
      CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in scs=
iback_remove()
      CVE-2026-23088: tracing: Fix crash on synthetic stacktrace field usag=
e
      CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_=
free()
      CVE-2026-23090: slimbus: core: fix device reference leak on report pr=
esent
      CVE-2026-23091: intel_th: fix device leak on output open()
      CVE-2026-23094: uacce: fix isolate sysfs check condition
      CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.
      CVE-2026-23096: uacce: fix cdev handling in the cleanup path
      CVE-2026-23097: migrate: correct lock ordering for hugetlb file folio=
s
      CVE-2026-23098: netrom: fix double-free in nr_route_frame()
      CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices
      CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is=
 fully ready
      CVE-2026-23103: ipvlan: Make the addrs_lock be per port
      CVE-2026-23105: net/sched: qfq: Use cl_is_active to determine whether=
 class is active in qfq_rm_from_ag
      CVE-2026-23107: arm64/fpsimd: signal: Allocate SSVE storage when rest=
oring ZA
      CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB=
 memory leak
      CVE-2026-23110: scsi: core: Wake up the error handler when final comp=
letions race against each other
      CVE-2024-58096: wifi: ath11k: add srng->lock for ath11k_hal_srng_* in=
 monitor mode
      CVE-2026-23093: ksmbd: smbd: fix dma_unmap_sg() nents
    added commits:
      CIP: Bump version suffix to -cip17 after merge from stable
      arm64: dts: renesas: r9a09g047: Add TSU node
      PM: domains: Add RZ/G3E compatible to PM domain detach list
      arm64: dts: renesas: r9a09g047: Move interrupt-parent to root node
      arm64: dts: renesas: r9a09g047: Add DMAC nodes
      dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
      clk: renesas: r9a09g047: Add DMAC clocks and resets
      arm64: dts: renesas: r9a09g057: Add TSU nodes
      arm64: dts: renesas: r9a09g057: Move interrupt-parent to root node
      clk: renesas: r9a09g057: Add clock and reset entries for TSU
      arm64: defconfig: Enable the Renesas RZ/G3E thermal driver
      thermal/drivers/renesas/rzg3e: Fix add thermal driver for the Renesas=
 RZ/G3E SoC
      thermal: renesas: Fix RZ/G3E fall-out
      thermal/drivers/renesas/rzg3e: Add thermal driver for the Renesas RZ/=
G3E SoC
      dt-bindings: thermal: r9a09g047-tsu: Document the TSU unit
      PM: domains: Add RZ/V2H compatible to PM domain detach list
      soc: renesas: rz-sysc: Populate readable_reg/writeable_reg in regmap =
config
      soc: renesas: r9a09g056-sys: Populate max_register
      soc: renesas: rz-sysc: Add syscon/regmap support
      mmc: renesas_sdhi: Add suspend/resume hooks
      mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() a=
nd pm_ptr()
      mmc: renesas_sdhi: Deassert the reset signal on probe

Best regards,



