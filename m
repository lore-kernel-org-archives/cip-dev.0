Return-Path: <hiraku.toyooka@cybertrust.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410D4D116E2
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 07:47:58 +0000 (UTC)
Received: from ss11.sbt-mailgate.jp (ss11.sbt-mailgate.jp [202.241.206.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16163.1764575269465455285
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Nov 2025 23:47:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: cybertrust.co.jp, ip: 202.241.206.55, mailfrom: hiraku.toyooka@cybertrust.co.jp)
Authentication-Results: ss11.sbt-mailgate.jp; dkim=fail(No signature) header.d=cybertrust.co.jp
Received: from mail.sbt-mailgate.jp (sagproxy-out12.sbt-mailgate.jp [10.16.47.42]) (envelope sender: <hiraku.toyooka@cybertrust.co.jp>)
	(not using TLS) by ss11.sbt-mailgate.jp (Active!gate) with ESMTP id BQqI20241B;
	Mon,  1 Dec 2025 16:42:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJqCW2C/+LUt9d3unqVGU1tssyeGjVXWDszgMmEdwL+U+MpPHg0oJBCQUzpCTFtKPe5v+pZ9vmS8bseGP04L9oy2FAotQn530TecFMQpqtrLcwis/I+ldm0wiyCqHyZi2KA+dUUhsIqE3aHclRGiGtLbc81o0DQXPEZ3571klWbMIIPtEJF/oRXKvqHfwYLlWQ5aT5yUm/saMlH2X1U7SgHOQ38zHkc0nQxElA9ygxJc9lj7PxHtyhO72qAEHxSUnQDvIW1bUgPiY4NVwD5w/wx8whh0t9vBOcM5OGOb3oNAy4Q+H88jQMUQDMNHsa9RCrX6M1VKUgjt1CJhaFDKvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QplPT5u4lIfhTU3f55n6nTed1NdHFVWnyse1GBFZH0Y=;
 b=PA6MGtuGlezRE2dSweGMLAc92N6HFGmMi2gHEs+yESyUG05UECJaC/ptBHa3W7IK/ubcPoLUR8QQESN+rWfWK1cXTll0G8e/O5OC4E8YfuPiyMb+oK/1a1yMxW4VTTZRPwti0sBz1NlQVsd1UFdZKsdoqdsdwUoLjc3NcDGnVKcT9uRssv/igPFmD6gQWqH9/kqHDLpw11fjmOz4c8lPbHvLszdj33nawX8ckVrmphgupAsLWo9hWwj5bXOg5zf08nkyEM7xwBuUVVizGXjZIVtV7IfOYmxmZrWVqVAB6cN5L8YMFQh9ZCABBuo7BslOsieIZr69o3xx2OkmcxVwsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cybertrust.co.jp;
Received: from TYCPR01MB7108.jpnprd01.prod.outlook.com (2603:1096:400:c3::8)
 by OSCPR01MB15737.jpnprd01.prod.outlook.com (2603:1096:604:3cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Mon, 1 Dec
 2025 07:42:06 +0000
Received: from TYCPR01MB7108.jpnprd01.prod.outlook.com
 ([fe80::68d7:168d:8b4e:f299]) by TYCPR01MB7108.jpnprd01.prod.outlook.com
 ([fe80::68d7:168d:8b4e:f299%6]) with mapi id 15.20.9388.003; Mon, 1 Dec 2025
 07:42:05 +0000
X-Forwarded-Encrypted: i=1; AJvYcCWdS3vJhBJWHS2Ck3e5yvD3Fq+7xyuwSVEAXoE4suyrF5DFDITlQMPSXbSNNi5KfirsxXEcsLpsBzeE@siemens.com
X-Gm-Message-State: AOJu0YwxqTr73g/OhcQ26+DJZSRNc11/07v6SbQaG3gYjLr0KSn6GRWU
	JtO+rtH3UG/2a3/oU5oSPjH3pjibBX+HMZ4SM65o7ba5jSoZNr3y8VHEapBc+pck226uls7ma6P
	7X96F4U/ZPGZqc9MtRimmK3AZYxlh6+YzyuI9HAgDiQ==
X-Google-Smtp-Source: AGHT+IHZ1RqYBgaMYoMlOuOcB7PbxenwCCoS0wY6yooae4G2UMlzsLv7TjbfrAZktqjHnnOdYv5dXuiT72yWsBnJ9Wk=
X-Received: by 2002:a92:cd8c:0:b0:433:2fa2:a55d with SMTP id
 e9e14a558f8ab-435b8e5979amr246895605ab.12.1764574921585; Sun, 30 Nov 2025
 23:42:01 -0800 (PST)
References: <d557dd8e-3f5e-403e-b741-7e4c32dee062@siemens.com> <TYYPR01MB151324B0FFB58A3F654CA8041B7DAA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
In-Reply-To: <TYYPR01MB151324B0FFB58A3F654CA8041B7DAA@TYYPR01MB15132.jpnprd01.prod.outlook.com>
From: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Date: Mon,  1 Dec 2025 16:47:46 +0900
X-Gmail-Original-Message-ID: <CADPJy8XYCDEgxuSvWwOL3Kf3-P48nZbS672+sc=yq=w+sMcAOA@mail.gmail.com>
X-Gm-Features: AWmQ_blzBu62Zg5X4qLKxUKC5NSJUhEgtWJli_hACPkukTamZyulZwFRCnIdhGk
Message-ID: <CADPJy8XYCDEgxuSvWwOL3Kf3-P48nZbS672+sc=yq=w+sMcAOA@mail.gmail.com>
Subject: Re: Enable KVM for x86 qemu lava devices
To: Chris Paterson <Chris.Paterson2@renesas.com>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>, 
	Quirin Gylstorff <quirin.gylstorff@siemens.com>, iwamatsu@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:610:32::7) To TYCPR01MB7108.jpnprd01.prod.outlook.com
 (2603:1096:400:c3::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB7108:EE_|OSCPR01MB15737:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a379a4d-dae3-494e-5cfd-08de30ad1fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmZXZ2lPd0RzQ3hHV2U5VGpCUTZKV1J6NEk3dWhXQS8xVVMranZUZ041T1RZ?=
 =?utf-8?B?Zkw3Vm40enJDVjdnNTd4WHM2OUlSY2VGM25RTWprVDA3b3hWcVpEQXdJem1n?=
 =?utf-8?B?YUhlOS85L2tVMDllYXJ1eVlsa0JsVWlWRUdKYkZpdG9WMXRiV0x2RFZzdXBP?=
 =?utf-8?B?WEIxOVJZMlplTDNyNEV2K0c4MVRWYytLeURzSkQ4c3doa2k0VUh6anh4bjN0?=
 =?utf-8?B?YmZiUWs3VlRrWXNxclI2VU9IMDM3c0Z0WDgvaUlxU2xDZ2tpYlBsTDBqczFn?=
 =?utf-8?B?WHdEZ3ZWcTgrWFlpYmM3N3pDQTIzUWVHbFQzY3Q5QVE0aXRpS2JFb0VNSndI?=
 =?utf-8?B?b3VmYXZKL0xPNWNBSG5CWkVsU2J4Mkp5ZVdVZUxhN29qQTV0YzlseEpmS1VB?=
 =?utf-8?B?M3F1bTdYL3ZWc2k0VlRLNldja01sYWJvRENmQVRQWm9tRWZxYVVHK1ZHbENw?=
 =?utf-8?B?a2Z4VnFlRm5zUXJ0YjdnOXpXNDE1bzNGWncwRXJCc28yUlU0OVZUUDI4dzFC?=
 =?utf-8?B?ZFZkUFVPVXp3MHZaamMyKzJaL1c3dXViMTQ2RjZNT2VVdUdwbXl6QklwYWxN?=
 =?utf-8?B?NjFLaTN0cC9RZyt1RzhsaHBXbHlicHJGTmVuUDc2WVZlNHl3c09UQ3V1ejNL?=
 =?utf-8?B?NkVjL1U1ZllmSUJHN0xxWCs4N1o5dC9mUHV1U21ENWFMdE13cGFxbWJlMEFi?=
 =?utf-8?B?dHhuS1U4Umh3ZXlvSjVkdGpCTm9DZzh0RjVTUENKRm13c0RyZC9SbGNnZjR3?=
 =?utf-8?B?ekQ4bkJDb2l4K2ZaaWpOa2xyaHp2dXNhdml2M2lqMzlzY3AxT2ltMWx3dW81?=
 =?utf-8?B?VmRTM3lYSldZVW90NnY0TGRKMXBRL29YYWZuTDV0a2VzNzhFR2xnMHluY0ZM?=
 =?utf-8?B?RlRPZFVRK1prUVpPOG5MR0FQMlNrN3lhQXlUY1RiR2EzNmppS3JQdXFYc0hJ?=
 =?utf-8?B?cVNxbTI0NmhiUkhxeG9LYTlINFFSVVNrNDMrc1FPYnh5OFRoNWdDYmhoUDFX?=
 =?utf-8?B?TzRjcnV4VHU2RU80ZnFqQStOSmRzTlpidmpKcFhtS2V1OGI1eG9YR1d5L2tz?=
 =?utf-8?B?ZlZvekdrMmR4N0ZhZ096cUR6R2l4SkJZbytzcjg2anRYeHVBem9hZVpVODR6?=
 =?utf-8?B?QTBPeFl5RW45V01KMEJOTUMxd3hqdWdtTXFlR01LRUFMbTRMbHpQdnBPVElm?=
 =?utf-8?B?NFVVZTNhM0xwYVFZYktJb3ZCRFdYMTRlR1BIaXBMSXhPWXlIZVpxcW9JcFE1?=
 =?utf-8?B?M1h3dmUyMm4yVzZrNVZzUmRvTW5UWkc1Nit6dXgxbnVIbWtkV2N3YlNKTUpQ?=
 =?utf-8?B?UmRQYWJxMGdRd29wNm9zVXV0cFhYZ1pFRDk4Rzd1Z1cwNkZZY3V3Y0hWVEFE?=
 =?utf-8?B?WnZqRHgvVkZ5UkszUGZFUU0vVHY4aG5nQ1E4amxrYi9EeHEzc0dOT0dhQlpZ?=
 =?utf-8?B?L3YveklrdnIwRTJpR0JicHFodUxuaVMzaE9oZ2xRekMwV2pJSmpTRkM1SDdv?=
 =?utf-8?B?cjh0WXNnWGtUdmsvNmpzTytFV1dVS3JlUjB6WUJjaWJ3ZDh5YmFmLzJBWStM?=
 =?utf-8?B?dnpBbzJpZ2o5YVlEY3pHSjN1dG9iMzFFZ01mUks4M1M4SWRjaEFxWlF3TU9l?=
 =?utf-8?B?ZktUQis1cjBOTEg0eTJHZWl0Mm5VanFXTTVtSW5STHBqbHdFL2pyZFNFalp1?=
 =?utf-8?B?UUVmK3h0c0ZqN3A4em5sWnZGMHNPRmFGcVJXMUlmVGxsNHQ5ZXZ5MUVHZXNR?=
 =?utf-8?B?Ukl0UnVnMUlSVDBSSWI0OVg0SjNxcUYxQWhFbjQ0emJVNXEzSnR4WmRWMVdJ?=
 =?utf-8?B?YjlUWCt5ZEdUalpxanhmR2tobDQrdkowa2pYc0dydG1WSktGVGY4R2QxbHdz?=
 =?utf-8?B?SUJRakRvbHBtSVBJODVWVTFRN2hxUDZoYzVsbkYyYkgwcHRBRTREZlV3VmRy?=
 =?utf-8?B?TVV0RXgrTlYyV2VnN3Z2ZHpLRDl0d014Uzg5dTI0YjNJbVBhR3FMSE5Bczk4?=
 =?utf-8?B?UHBycXdScDVaZWxqeUNwQk5WTjJ6NStVSmFGeTJjWG4xUHlsVVA1ZFdVajky?=
 =?utf-8?Q?FxW5y0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB7108.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmhmTlJsOTVYWDhLRDVJWjhjWG9hcWJQNk5ib0cwRms5cW45RGRIeEl0WTlo?=
 =?utf-8?B?QzI4alcrZVI5Q3RaTmNXQ0h2YnF1NWxvcTJrMHZNUlZJL0xzQ0FOSFM3YzNV?=
 =?utf-8?B?RTlPU2Rmc2lyTUtKRWhwUHY1emloYU92cmliblB2TTVoV1BxL3hzOWxEUzhC?=
 =?utf-8?B?ei91RVNYNEMrTlFBWDhQUUtERUdZdlk1bVpoYWhJOEhBQkQvTGVLUlE2ZUdF?=
 =?utf-8?B?MWJFKzJJWDRKVzhKV0xxai9qc0t3YjNDbStQaEllWWF4S1Fqb0pTS0hjY2pC?=
 =?utf-8?B?UXVOTnJkQkpoN3Viako5RDdGTzRYamdjaE53T2NJRlN0Ti9iYUdOaytiRXFI?=
 =?utf-8?B?OXJUMExETkg2YnlvbkR0bjRxSXloTzlDeDlBSThGOWxLMm9id0JSY1h2RUE4?=
 =?utf-8?B?OFFsRVFndStVWHJMd3RWekhQaThHWHlzTjNrTmNtdVUveU9RYTRkU1pOVHo3?=
 =?utf-8?B?RDB1Umd6eUF3KzY2QWw3dGNpWkVtaWNVSC9ReWtqbjA5RGp1dTdtQ0xGZ0Vo?=
 =?utf-8?B?YjRHNC9kZU5XRVZlZ2VrelM0ZUVjUUNQVVptMnZhaW93N0k2MGUyMDlKbmZt?=
 =?utf-8?B?SWxhZjhVRE5BRWFNMjVzR3pHVjhqeHNMTXNsQzUyT2w4cSs0aGlyZDZoWmZI?=
 =?utf-8?B?REtnRG0xUXFOeXcxYnVWMW1kNGhBRElqY083YTl0YXN2OUhjbWF1RzB5ZTJP?=
 =?utf-8?B?dkFZYzgvSHZOQVRRd3oyWkt5VTRHVTRmQ0gyY1B1M0lxVVJSdjZ0Rk9sVnJi?=
 =?utf-8?B?cVJVVmNNakZNYll2Z3RKV3VndjB3Tno3Z1Q1OTd1d0hPZi9SeWhVL3FSWGd2?=
 =?utf-8?B?Z3JhWjFLWi9MQTVlK3dMRlJqWENKU1c2M2Q3OVBrUXl0QmZlTldIR2oyMUY5?=
 =?utf-8?B?b1lwZUU0K2czN2dOZ1pKMEZoL0FUaHBDbWJSWjlSOHFuK0U2M0VIWjFaK2FF?=
 =?utf-8?B?NDdyYWVFV0RtSUJVMzg3YnA5ZWR3aUphYlFDbndHMU45aG1uRUFqYWNja0FT?=
 =?utf-8?B?b2xWT0hBUjZRM0ZPUlJaeURvODIxdEZ2Yy9Hd09aRXFTa3ljTGF1UDh0cVJp?=
 =?utf-8?B?aVRrUGNBcEhCUnRHc2VORXhXaUpSUFJNSGRvbm1EZ1FzT1JFaVpLRGMvZitz?=
 =?utf-8?B?OWZmYStyUTdWVkMzaC9MNTR6Ty9zeEdOYUZSVnNPM3pWNktPUjRZc29LZ1E3?=
 =?utf-8?B?UXVGeDBrVHJlTU9ORVo4cGZZb0NTVnBqNUhCV3JwaEQ4OEtQN1J2dFB0RjFY?=
 =?utf-8?B?WTVSL09ORW43YWtkZHE0anZFTEF4Z1ZBRFk1QTRoeVpKS2ozWWV2L0ZtRS9N?=
 =?utf-8?B?bm80dXVBMWJMUDl0VkdnVmRWbllLQ2dsSjRvNG1CS1YvK0s5Q1lKd3oyZ1lz?=
 =?utf-8?B?TTVnS2JxMW9HK1Jrc24rWDA4T216c245V2lWUXVoRGV1Y1U0SzVTMW1RTDIz?=
 =?utf-8?B?YVB0VVY0M0tWekJhVXJLQkNDd1lNUGdEWFpLM3hDSm1Vc2FnQWZLUWUvOXdZ?=
 =?utf-8?B?OXdsZDZLYXJwcDZxQUREcUxOMFJ4VlRQdjZzVGw1T2pnQ1VNNURCWm45MFdY?=
 =?utf-8?B?a1NKZ3RrYnBUSUVLVzVaMkNvcEdCblEzbkpheUtkcG43QWE3enRNZndpRjJO?=
 =?utf-8?B?bVNCY0llMUU0UWhlKytNU3ovNE9YWVJTaU9FRHk1WFNzSk1oeVhOWEdRcTJn?=
 =?utf-8?B?L1BTMTN3Z0JyTTE5N1liS3QrK3VjSzhCMWhiUzdoOGd6TUs3a2ErbXZtN3pk?=
 =?utf-8?B?dnp3NWdoeFZpc3lLVUVkNUdkUW1jR0ZnR1piN1lwcEp2dW82Z05kZm5QemxP?=
 =?utf-8?B?NTIwU2x3cmdGdFgvRFpoY00zU2Y2dysxbThzSmxWalFBdGphdmgwdFRyTmEv?=
 =?utf-8?B?M1RNL3c2T21PNTd2aDBTMVBmeFo4RVUxRjVyQ1Z5Tm52Rk9sdjZIaGFvS3Vp?=
 =?utf-8?B?TXlHM0o2U25WR3l2M3BHYlJkT01IWGNuempkME9HQXBWSFBDLzlyZ0tSSm9K?=
 =?utf-8?B?NU9KM29OWkpuZEUyd2MvbldQSzlRUUJ1NlB4SllnQ1RhcHl0T0l3bVNJMFU1?=
 =?utf-8?B?OXVFRTVRa3hobVRadjErNE8yZnlna3NYWkNHNXhIU0dEYzVPYTRSbzBvb2U2?=
 =?utf-8?B?VDY4TUFGOTFtMUozRjQ3MzlWZjJodElJNWdOWWtVYkNkbVFJTFJOSXA3VnU2?=
 =?utf-8?Q?yVzVnGEjXO58zAWBfLTr8ms=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	6KVcc40j6tfZVxrJWsw4MnotNPh8vGII8qvkSP6Xrg+8ktDufAXRbFlDxVaT5xcBeu0E88ABzDiHmMrV3vdYQ95vUTc1cp7jAihOGeyYhxzZG6DQ/CBvhaENgUfCxEhNPTysTJAvK5VOjITichWMG8rumOI6p8N0c/Kn1/qu9wzQLPvLIGlMxjofs150ndR7v2bAoDLUfa3D0LlKGdOUnhdP2xeIfnOeQP/B9gDzfOXn34HlI6NggVgcF3VQPBzLL5tGTNbJGuuZFtzrFcLQ01tUmPbPq18tZUHIc+rUklHP/1ts27S5j4lEI9VvwH205lpx65jgUkuoLSbOB6rXMuW/08SakaA27p7zkUQRTGQ71ai9EllUWuvUAi0RrsyqqSbvwVUQECNukC8/cQJO3Fw9u9MFZi5TbC2UIGrtrF6nBWgDWib5JupSNMlm+k/Q39oMT7UYMGWIN/Y/trXGLxwcwMEWv1cIqdD3hCOBAZ+tkoyMGhTXRidkEU4z6PZSP8zjghIxri8rsJHI8xmAEYEELFxW4PyFLvRgi1wemE55oNpD+RRJFSa0m6QgXGGNZQaoWkH0c4WknVaJX2FmJtkBFmPaErohi0wq3XiD7W87+HqmsF53cn3Jp8OVlHBv
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a379a4d-dae3-494e-5cfd-08de30ad1fea
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB7108.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:42:05.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8cabM5gyLAN1uK0Jcn7cH94F5/p6F8F8jUOmSFzaVIHzIdPEVBxw4KV95TvNqJpJEb5zbe3DbQY9sZksv9vIa/BGLCf0fTp0ylnZLhcglg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15737
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 07:47:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20774

Hello all,

I have enabled KVM for lab-cip-cybertrust.

Best regards,
Hiraku Toyooka

On Sun, Nov 30, 2025 at 9:21=E2=80=AFPM Chris Paterson
<Chris.Paterson2@renesas.com> wrote:
>
> Hello Jan, all,
>
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: 28 November 2025 10:19
> >
> > Hi all,
> >
> > it's almost embarrassing, but we are still struggling to get our CI
> > running with trixie images. Another blocker was identified today, and
> > that is insufficient CPU features when running with TCG(!) qemu machine=
s
> > for x86 in LAVA. I played with lifting TCG features levels up, but
> > didn't find a matching CPU model yet, and that might also be because of
> > missing qemu support in general.
> >
> > Both from the feature perspective (forky will raise the arch level e.g.=
)
> > and the parity with local execution (start-qemu.sh), we should really
> > switch to KVM devices only (for x86).
> >
> > Quirin identified that the following labs still have KVM off:
> >
> > - https://lava.ciplatform.org/scheduler/worker/lab-cip-cybertrust
> > - https://lava.ciplatform.org/scheduler/worker/lab-patersonc
> > - https://lava.ciplatform.org/scheduler/worker/lab-cip-renesas
>
> I've now enabled KVM for lab-patersonc and lab-cip-renesas.
>
> @Hiraku Toyooka, please could you do the same for lab-cip-cybertrust?
>
> Kind regards, Chris
>
>
> >
> > Can we change this?
> >
> > Thanks,
> > Jan
> >
> > PS: This one is currently under test and consequently fails depending o=
n
> > the device:
> > https://gitlab.com/cip-project/cip-core/isar-cip-core/-
> > /commit/321c401d1de763ab9b7c7afb0c13d26f0a70b7c5
> >
> > --
> > Siemens AG, Foundational Technologies
> > Linux Expert Center
>


--=20
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

