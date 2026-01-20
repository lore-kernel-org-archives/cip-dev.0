Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27CDD2ECF9
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 05:04:11 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.264.1768885444661080632
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 21:04:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=rwmFSlp1;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1768885442;x=1770095042;bh=LdPNvmj4s0bNs8Z26AhERGC5mNnr4CPVGTB9h
	9p6fgU=;b=rwmFSlp148LuhT5uie2g/2S/2K16rVr21iTUAv3OvbLVFnVZAqdyuXwv2x+zoVIECYV
	22TMQ3rsGgoSMxNSdqTGHty38w88pnOoBj0vALMe9wclfczZFY1OOLEMRshEvIkk7AV27a1fpLkxX
	GD0stjFucICrZvDMSMh+x/yQzcqCYUrFVllG911B1brjFF6uR8um1CN9HY7Mx05u+PCUAdsfSFLjq
	r/h4C/n5+ILClnm+pMs6C/QxGewYSbsoVF0utKLWW/Qd9anheBXoexI8C3Rp+HGiIUSbbAS/K2gNR
	/owhBJW6630OHFRA5fJmpMpmZm78KbDcLojct8lFpMxA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 60K542RS2692263; Tue, 20 Jan 2026 14:04:02 +0900
X-Iguazu-Qid: 2yAbS7rJlCSHPgY7Pq
X-Iguazu-QSIG: v=2; s=0; t=1768885442; q=2yAbS7rJlCSHPgY7Pq; m=dfTIhN7VKLPrBG3US8eB9ApgQGODt8FhNk3M+6cMBHA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dwFbk1YMwz1xnZ; Tue, 20 Jan 2026 14:04:01 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAAmdGjK6qJs6WfCpJrLQHwRPxmBAXndW39z+0CLAvCRWL0imIrrGe/AcgOfT4bYBZEFCkN7Gy8HX4xPpHwIfLUl+/MESk/ZMltIzaU4Is+m7Ri6d8qfOOR7+4q4vzj/gjyK4DJJ9nyIBrLn7XcL+PcBicE4Vae3lcQnMf2c/sMuUUr4agvk871ni75XvJd/+4InlYZlsu8tNRftYeRVLFtmCGOPlY/SBVhE1Py5kGIkb1TrYJgtxpa4KCcWBPEzejbb+80rTQoDDIL0sDTLKiNvuOcc475ZJvo17EGY4/0Qu9S+MxD33Jqr//ZNxlfEsT2br2r24athl5rGH2IWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/sQKR9ajRnP4n3JZSKoF6P41TxMy0Kolgxp8n5s9dk=;
 b=Miya4h6pvNIFoOVXa3VE4rvv3FrPNyKt0D15x+3OnEDp1V+En5rJDbskcHaTF6OBOOcn8fz3FSvsqQHpgjBqKsZWG0b6AJUbCzHUCa7tQ5kHVWl9FsHFnsWNmOMkNrYBjOHFeFnoyTYP2b9fbdcopTpwB5hJpm3Dkpm7/uph+x95TRHFE2G28jRtnjTHHgoMF5nHpQrmUTVS74hiyUv7l/c7XyrKVJjsZmizOiG6nB6MlgNUind/r6+sACQvW7i0YeLw8Nf3vSNAxKgHNfdPTpn6Ihf3wg91gaycGuhX/bPdWGcG5MsxiphCFbzqcNJRmKlC7Kwvj70Hfrmr9WLBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@nabladev.com>, <ovidiu.panait.rb@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N XSPI support
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N XSPI support
Thread-Index: AQHciUK37P1nd3pmgkm11968GgIAIbVZpVCAgADcHCA=
Date: Tue, 20 Jan 2026 05:03:59 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481876A6F6D68BF840F23156CD89A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20260119125403.32197-1-ovidiu.panait.rb@renesas.com>
 <aW5Tv2kw6k3mDA7C@duo.ucw.cz>
In-Reply-To: <aW5Tv2kw6k3mDA7C@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY7PR01MB16870:EE_
x-ms-office365-filtering-correlation-id: 2a8410e1-f20b-4bbf-9e58-08de57e152b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|14052099004|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MzBWSzBqYUNYQi9jem9Ba2t5elV5Q0U2TEF3Ri9Bdzh5WWlUNStHYzA0?=
 =?iso-2022-jp?B?UU9WTlBTWG42SVB0WTlnU1IydzlpQitaQUIzU0llZmVjc0I4WHFFRjJ6?=
 =?iso-2022-jp?B?NDVaNHpzTE5EOCtKaHhTdFRJUjNtSUJIVUttNXNuZUpEQ1cxOGtxeUpy?=
 =?iso-2022-jp?B?bXFFM1QzeU5YZmRPM3AvZVdJaFhmR2JnS2R2NGpxTEZGdEkwNUpvTHp0?=
 =?iso-2022-jp?B?QUFEZ0FaL1p2WStZSXBWK2tTbnRrT05iS2owVHh5RUZoSkJTc1F4OHBJ?=
 =?iso-2022-jp?B?ZW5KTnVFbmF5L1FoZ1lGNENzU25xN2V3ZUl2ckFPWGRFQVorbVpZNnNG?=
 =?iso-2022-jp?B?bUxvRmVJUVRTVnNDQmZKSHo0Wk5oRko4bHpPa3dkQXNpUTI5OUlPSlB0?=
 =?iso-2022-jp?B?eTdHQTNOa0hWTmVkUGtSM1NoQlYybjBnbThhcG1PMllScDA4L0kwdkJZ?=
 =?iso-2022-jp?B?QWJCMjVCYmMxemV3N1B5cjRXT2tGNkFHZlJKUWovVUdPVnpBb3ovODFm?=
 =?iso-2022-jp?B?dG9YdUcyaHNnYzNaZ1hYTjVNd3NBcHh4TFMvNUFWdTI5dlByTFJHQ0xJ?=
 =?iso-2022-jp?B?SnN0c0ExNlBjSWFlZTNOOHJtZzNCRDFoVEdUMkRydG52U1N0eXNzaExw?=
 =?iso-2022-jp?B?UWdScHFzb05LdFNTQXN1d1VyRHFPaU9YNXkwbHZBMC9VZmswRUFCNjNU?=
 =?iso-2022-jp?B?V1hFSXR1WUFZOXk1NUJBb3dGV1hXU1pVYnpwSm5DMG5lRXp5emFSK2Zs?=
 =?iso-2022-jp?B?ZmRhM2IrdW9xQ0NrRlBDNUhLTVF3T2ZxYTJXVS9qWnFLS1lWZ1dndi81?=
 =?iso-2022-jp?B?UkV3bVpDR2VyQ0ZRdEI4WWM4aHhYUEJXZDdlRk01ekhKclBKclNsdHdG?=
 =?iso-2022-jp?B?bFJpY1pic1RCMFMyenFKL2hKZlFveHN0WlFZK1d5Uk4ya0F3dDB5VzRY?=
 =?iso-2022-jp?B?WGFybkdvdVdIRWwzSWFlZmRQTXppV1NrTXVMSXQwbWFaNlBWR0hybEtj?=
 =?iso-2022-jp?B?ZEt5R3NjaDB0aUtQSEJ1MFhIdFhZOHc2MFZ5U2dJVkVEYWJuWjI2b0FX?=
 =?iso-2022-jp?B?OHVNMFhoM2VjSjhWVlZac1gyWWNKZWluWVo5UzRoRmZyT0ZXOFJWYTc2?=
 =?iso-2022-jp?B?Tkt3Y3pVS2h4cjk2OEdNdUROeGNoOEl3UkttU09tdWhoODNJTFcyZE9u?=
 =?iso-2022-jp?B?VEZSKy9XUmxReTgreVB1RytJOHM4Tk9qbUVZTWJsckRiL3pycDg5R3dE?=
 =?iso-2022-jp?B?SjdSWVZqR2pjNzM3a2FCUnhzcGQzakxrQXBIU05NTUlhZzFqUmJXbmwz?=
 =?iso-2022-jp?B?OGk1Ynk3UGFBeXVtbHBmSVJLbjZCL1YwWXR2MlV4NXNWZFhPQUdtL3Zr?=
 =?iso-2022-jp?B?Vjc3bkZlbDYvWHRXYkZZdUtVU3BEMDN2ektIQWQ5T1drVTFBc3drSUJV?=
 =?iso-2022-jp?B?R25iL2tFM25mNFJiOWl6VzFzbmNLTnFuMytLU1hNKzA1Q2VSMFpGakhv?=
 =?iso-2022-jp?B?b2RlNHJyMjEyLzQ5WGRZT2tkRzRtSkNFL2p2UnZRZDlxb2YwdFQxa01Y?=
 =?iso-2022-jp?B?djJwTHJncEJiMXR6K2hzRmhjdUI2NTh0bVBldHhzWkVONWhWTkpsWHlL?=
 =?iso-2022-jp?B?Zk1GUGF0NGpZVkZRVmtCYTI1KzY0Q0Z4K0ZzZ010aTc3bW1KMTFkMFVo?=
 =?iso-2022-jp?B?TzRoSGx1SDE1a2V5U1NKMldYYVRpY2YyRjFSYzZ2V0RoemlONnJTd3A4?=
 =?iso-2022-jp?B?VHl2bkIxOHc3NXZvVXY2dm9vQUdFY0VMT2hJKzZvVDBtRE12WkNXTE1j?=
 =?iso-2022-jp?B?cWxBVG1NVXg5czE4amZ2NXNrTzVjanlJcTNHcDdnbXZIdFlXcnV6NHhZ?=
 =?iso-2022-jp?B?V3pvUnQxL3pYUXJ1VTljdG04MWVSM0kvWnlyTlhlZURraEJaL1NBQVFV?=
 =?iso-2022-jp?B?aGUxNGduR3Y5Zy9DTm9LcDJLNENGMmdLVGFiNjcyNWJmUWRMdGlSYnFT?=
 =?iso-2022-jp?B?L3pHa0pYMGE1SkZmU2UvWWNzZ2Jsc3JoaGh0eE02Sll5dFdKUWRycWkw?=
 =?iso-2022-jp?B?S1ZjaFZFL2M2cVpJUThSZkRzWTRxR3JORXdvRUpSNi9YTE1sS2xLZFVq?=
 =?iso-2022-jp?B?Z1ZDQWpCd1V0bzd2bGFzNE53cVpxaklacUw3M3JBN2tBWEsrU0FPa3VF?=
 =?iso-2022-jp?B?NDlXelJaRHBxaXFLb2t3U1l6NkVndnNIZE5aUExBR0tzUmlFNlRvekZx?=
 =?iso-2022-jp?B?ZkxYSUtDTkZpQVFEWjMyMVd6UUMrQ2VTNndybnBXZWJsNG9WZlVaQUxO?=
 =?iso-2022-jp?B?NXNZcjg4V0x2Myt5cnVMekpTWEdaTkJFaWhjVDE3TTNBMGJXcG01cjhi?=
 =?iso-2022-jp?B?aGpvMFU9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(14052099004)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?a1pYR3hMbG1iNkFXSXF2VjVtZkpPaHlVNVc4RmtWWUFER3FleHQ5RVZi?=
 =?iso-2022-jp?B?dTdNVVExVC9IQzY0QTVwOEY2Unp4azdXRE5zSVEzQUxWb2JoQk04U1d6?=
 =?iso-2022-jp?B?c2ZobElhR2J2bVAvcDg2VnA4SWZ6TDZUT3FKQ0RkM0dpN28rbXdnR0Iv?=
 =?iso-2022-jp?B?Wkg2YU94akVnZ1Vpenk4NHB1RGpSV3lFb1VZVmRzeWlhN2xYREJYMDVK?=
 =?iso-2022-jp?B?ZkF4dDEwa1dBNFlCWmNIdnJiNTN0Qng4OWl6Mklnd1lCTmJPTlgvamNY?=
 =?iso-2022-jp?B?SUpVMkZLeXJuSHMwV2FheE16a285eUhZMEZQeW1QeisvWk5abWs5ZVNK?=
 =?iso-2022-jp?B?TXh0cHczK24wWDNDQ1VzaHQxckx0OURvWndXUEt1a202Rm1KZ2pQRFhN?=
 =?iso-2022-jp?B?SU44YW9NT0hjdFNvYkJnTnFrRnVteGNWQVdTeVlMQ3hCUHFHUzU3b0o2?=
 =?iso-2022-jp?B?bVhnZHNjV09tTGtoTG52bFA0aXY5dWQ2OUkwRGJIQk80TGYzNW1nTFl0?=
 =?iso-2022-jp?B?eHNLT2hnZW1pSi9XRU1xOWF1TGpnb1ptN3hVWlFzWUxvbjIxa0dvYk92?=
 =?iso-2022-jp?B?bGZ2R2JQY3o0SmNUekJnSzZzZk5LWVFVYmFmQ0p4Z0o4NnFWSFMwQnEx?=
 =?iso-2022-jp?B?OWUrVEVQQS9BektIWGxqeURRWlJySXBORkU2UGJmbG9abnZwUnhmdWwv?=
 =?iso-2022-jp?B?YSt1cm5ucUt2YW13VWdXNTg2dWsyQ25ER2NlVUhzODkwNGRhNFQ5L2pl?=
 =?iso-2022-jp?B?TGxlQ1ZLcDcrTi8zQWVGay9Zc3dsRURsSzZIaWZDaTIvMm1IamU5M2Nz?=
 =?iso-2022-jp?B?NEh6dEgwMkRZaCtJYWFjZkRSenJlM3RYL0dkSFdNMzhiSG5vUHRhaDRu?=
 =?iso-2022-jp?B?cVNFanZYWTJzYnlxbTVtRFlWWVZaUDRCdXNTMmRvd0Vwem5hbnk5R1B4?=
 =?iso-2022-jp?B?UTQrVnBoV3VOeDJteUFTZW1ra1ZRcHJLa1Rxa05GaFVGcmZUZGR5a1dF?=
 =?iso-2022-jp?B?U3llTE03S1FpdlMvZS9YQkxpQmtqb0h0b2lGZG0wZWJ3ZW9xTldsbVgv?=
 =?iso-2022-jp?B?YzJTdDRwTWx4bW9QQXVIZWhTVDBkTitlTmNYejhMOWp3clZqRmlWODFG?=
 =?iso-2022-jp?B?WFhCTFpjV2ZubFFVUGlVQmpVdEdncTZ5SS9rc3VocytZU2swalhDSVUz?=
 =?iso-2022-jp?B?YWg5U0lNMDNxeXpLbjBxYUMzTk9hSnpUZjJhdnVsamREcXFKUmVWSW5E?=
 =?iso-2022-jp?B?NXdhQWdESktHVWpMSG0wTmpYQTA5REViMWZ5REJCYnR4Tnc0YWlNSm9J?=
 =?iso-2022-jp?B?STRKVFIrdmUwUXE4OU5IaXoyQkVqRTR0MzY4TTFCaU01bE96Zk9DcktP?=
 =?iso-2022-jp?B?ejZQWWdhZkZ5SnE0SUdEQkh4ejlqTjBIOGNRT3pRbm16WWhYL05CSkts?=
 =?iso-2022-jp?B?VHEwRmluU2pWK09Fc3N1VERFS1Z5ck1oYkdGclJON1Ayd0JTUjRYZGg1?=
 =?iso-2022-jp?B?ZXdqTnErd21IZzB2RzNmK3VFcW91TmFBaDF1bjlaVlR4MU9Fbk1OeEFH?=
 =?iso-2022-jp?B?VGlRMjZrMUpOc1Q2eG8wTlhKR1hlekVOa2t6TWdsQ053R2syQ2tQanBN?=
 =?iso-2022-jp?B?SXRqQkRPTVUvaGhVTmFsZHY1d3pKbHg1V2hoT2pJdkNYQW9FMy93QUkv?=
 =?iso-2022-jp?B?WE5SZGMzbnpaZ3FQMHQwd0ZWejNjU2xIVS90eWY4cWp6UFdUNVluUllJ?=
 =?iso-2022-jp?B?QS9QNDRab1VwSjU2dS80UzdBZ3p0ZHhZTFMyb1JTMVN2ckY5cXRmRENI?=
 =?iso-2022-jp?B?OUxDaVlaNm5FYnRSTXU5OEZaL0xuVVdoOGxtTXJPUzl0NkpzN3NzaHYz?=
 =?iso-2022-jp?B?elJqSUszeWpMNHRqa0YyOGdkeEVUK0xvOHNGUmM3aWFGcjJkdXA4dFBF?=
 =?iso-2022-jp?B?K0xiVzZCVldhV0s4ZXBqOW9IN2tyUnpwdFRwUVhFVm5IK1pwWWJ5WUI5?=
 =?iso-2022-jp?B?eGZxS2pQWThTRUtESW9FQXhVWlBlVVkvYytvZHltdXFVOWxoQUpyNWN2?=
 =?iso-2022-jp?B?Q29MRGNmd0xQUHFCVGlGM3laMTVkanNWRzI4UExHelhZVlZFVXBGOWZk?=
 =?iso-2022-jp?B?R2xZWDFiVUk0NCtqTDRMNDVhTjE0YXhBWXErRkM1QjErbHUrRkp3bWV6?=
 =?iso-2022-jp?B?UWQwdXExUDQ2c3c3ZFpWTnJXTzdnRlBvaXYzY2dtYlJBMldPa0pyOHIw?=
 =?iso-2022-jp?B?dkRQUTFlYUhRR3ZWR0NtRGxseGQwT0dNWFV6K2xKd3J6K0cxZTFDdy9N?=
 =?iso-2022-jp?B?ci9zOG9GK296TUQza01NcjJZQWVsMkpBcEtwY05oVDdvaWUwVWQvdDNh?=
 =?iso-2022-jp?B?SFp3blBjMzVUdjRjaXBDUFkzekgxNHMraW8wdmVYYy9jSjBHaHdyNXlj?=
 =?iso-2022-jp?B?b1B5REZCaUJreDk1bWlkZHNBY3RZWjJiaENaWXBIaVAvc0Zadk00K3Jl?=
 =?iso-2022-jp?B?NlBlbW5FcmlZYmlpRDZTOThtZWRUSDQ0QzJTWU5FTjY2TkhFaXBrRjU2?=
 =?iso-2022-jp?B?K0lIeG1Kdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8410e1-f20b-4bbf-9e58-08de57e152b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 05:03:59.9255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p30il16rcco3VXSQcQOXmbKoG9ur/RIcKGreVn6ksmj84VtNXSxU31KG9qwv7qqlZMTW5qJ1F7y/pEvIX9PlBxphAiIBJnVGxf6Tyn+pdx716tieM06hJDl3ID2HhWjS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB16870
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 05:04:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21681

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek via lists.cip-project.org
> Sent: Tuesday, January 20, 2026 12:55 AM
> To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Cc: cip-dev@lists.cip-project.org; pavel@nabladev.com; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/5] Add RZ/V2N XSPI support
>=20
> Hi!
>=20
> > This series adds XSPI support for the Renesas RZ/V2N SoC and enables
> > the
> > MT25QU512ABB8E12 flash device used on the RZ/V2N EVK board.
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


