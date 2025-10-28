Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B64CCF9E0
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 12:24:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.10017.1761654242521316336
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 05:24:03 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59SCO0SO3581011; Tue, 28 Oct 2025 21:24:00 +0900
X-Iguazu-Qid: 2yAbz4OZcc8If8MnbM
X-Iguazu-QSIG: v=2; s=0; t=1761654240; q=2yAbz4OZcc8If8MnbM; m=AXJ3n9OtldmOklvZhEogAfBJNGuSvzpGfAEDaQQzAso=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwqL81wdmzyPQ; Tue, 28 Oct 2025 21:24:00 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GANBVgjncbZze1ubPZA5Tbg/q/as4zbRQm+Zw6vu4kAA6DkFuS/4h9LL8uwWie3vCEDMBrE8feitT8ghpOBrJOfobFCq2OmELgnVsCJ9/5hBM//w7HnAbrI4l3CUVxUWxNBer6nntQkzJQsR/1+wcUVQ+5/oUuLgqCzyS6Xio8xlHp1fHSgm3ncAUbrS1MgnjqZH98dsNV3oQtY0mcOtpQ+w8L0itUx/LWOPujUSyld5f1gKLncOUgbiYU5zxp1zO5fYN6BeVGCPjBlHyn6wji++QdwDIOR0MgYp5wguNWUoSQozttvAXx0pjMEPGZbrFugiilo0BDwSRiUCf7HD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8Nndj22scQvHIb9WrF8P+PB274cEOFzRnDnDWSLpiE=;
 b=gomlxjRpTD6f805ELXE4dhZyKQe8LUptWxxFy6VMMoK0Wmrdn9ocfbFD/IHmNsKHi8BWWQeP/zF7/E3bXntP701zFC0cshtFbJXRwlo8u5VbUXg+2fpNlp5CgRLaDWJa/esTpr711gc5O8P6f3TgTm+e7izDmfo1U7Dizja/GwzNWCPN11wx2XsQfXmFPubDKGlpBzfAKavwXumRm72H/le1iM048rXtvszCeU+EPJOayas0kmY4Qc60EQW8hmQIZe0N4iTLLbydUNUlkY9Jo/ODuBi8DF2HPIUTALuhR9Xkn2cYXPF5Fuu1jydLuFgJyCXg9Wnn/zeSmgvJE9O5vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
Thread-Topic: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
Thread-Index: AQHcQofrnXFr87F9i0aDfGYdXA+wbrTMjx2AgAjtMOmAAf7ogIAAB3WH
Date: Tue, 28 Oct 2025 12:23:57 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669C1BBAD337197C9365A91C4FDA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
 <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
 <TYCPR01MB966928ACDB11A20191951248C4FCA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ea2de6f2-5574-44e9-8c96-29d1ec0d3084@siemens.com>
In-Reply-To: <ea2de6f2-5574-44e9-8c96-29d1ec0d3084@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TY4PR01MB13803:EE_
x-ms-office365-filtering-correlation-id: fc51cb3e-4b60-4a7e-c17d-08de161cde16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M3JrU2hJZGVKVHA4aFgwMzVYUHhjTHNlblpZU3o1b05HSllCYlVxbFFG?=
 =?iso-2022-jp?B?M1JxdGJMSll0MDIyNGVWem9xR2pMbGVBWEVrZ3NOMWtFcDJ3VDZkaWlS?=
 =?iso-2022-jp?B?c2Q4NzcxMENWVFY4VTJBd1JXb3I1TFhobnBrOWhFbmxyNm5MMHg1bUFZ?=
 =?iso-2022-jp?B?ZkZtVUNEckJYWVhEL1VaSitBNENqV1pmYTNacDBpSEVwakhzSGdoVTdi?=
 =?iso-2022-jp?B?ZGNGYjdwWHdVTGFRMXJPRktjSkptUmRaSUluY0VwR1ZTVm1iL1pOSE8w?=
 =?iso-2022-jp?B?VzU3YkhseHlEcWhySElsOEh3U0lLWWhmMElKWU9MOXpaZHA5VmlmMXZt?=
 =?iso-2022-jp?B?TVZ1VHRlVEZ6aXJTYnorOC93RlhuUlUyQnRIT1RzczNhWFFoNmZZUzZo?=
 =?iso-2022-jp?B?UG9Yb2dZT2lKNFpNSFRlWUVjWU15aVAyNWRFWlVXWVhtSFFRZ29XeHd5?=
 =?iso-2022-jp?B?RU5Ndjk4SklValJQVVlDdndnbmdpbDlhai9vV0xkaUhUZXVuTU1PN3pv?=
 =?iso-2022-jp?B?SWF4TDBCRkRxdGRuMHBxaUVPdkZOTERwcHF1bHpjL0FRTms0emlnNHp4?=
 =?iso-2022-jp?B?dUFTYzVCcFp1ek5GUTZFTXB3Qkh1bC9PMkU1YStWY25MYlY3cElHM05k?=
 =?iso-2022-jp?B?OXBJWUJBU0RTTXR1enBNOWoyTnptbFFmcVJTdGIrRTR4Y0NZSlBuZnFL?=
 =?iso-2022-jp?B?SUN4Z1J3MW9UQzRMYmprWGxtUUNXWXQ2TC9PalRlYkNaQ1FmclhyM3hz?=
 =?iso-2022-jp?B?c1FEOTV3SVB0bWNvNkNBUEpoLzM4RXFKNHo0RWo3b0NkZm5DZzAzelNU?=
 =?iso-2022-jp?B?cncyMFZCNkU2eGMrRXhVRW1CSDYyOXQzdTlMOG9sb21oa2VYdUtVMVVV?=
 =?iso-2022-jp?B?TWZTK0ZZdjNjcElPZ2ptcXlyOWJiRGE2SmFGZU40Tk5TYTdWVEtiS3Js?=
 =?iso-2022-jp?B?UWV5Rkg5Ty81UkFtQld5TC91bVRVeTBiVU5hVkJTSkw0RkFLTWVzdHZ6?=
 =?iso-2022-jp?B?Z0tuc0FoNTJ4ZUFMYUs2ajVWZmF1aHNUUG8yWlFqdHMxa3NyTWsraVJO?=
 =?iso-2022-jp?B?RjhPcWlYVlRLaHpIZVRNdHZuZVlhZjNaTUFpd1BERjRZUzJpaW1PbmQ4?=
 =?iso-2022-jp?B?UjRBa3h6c0VaOGtzaEJiUHBrRkZwOFJNOVcvUXJOcXpodkQwemlKdUE5?=
 =?iso-2022-jp?B?MXJoRnU4YVFDQzVHNTNva09nNWxRQWxKYkVqa2RqeFhodDFXeDZrRmlh?=
 =?iso-2022-jp?B?NGdOYWF4MVhPKzJCdDF0V2NsanZxWVBIWW9sYnZPVW5uNzJBa3Z3a1dB?=
 =?iso-2022-jp?B?QS9pUWRqbUJCMUh4N2U4bkZUWEFEdS9GOFJSb215aHhVTWFTT2hzMkcy?=
 =?iso-2022-jp?B?MVdXbThRSFM1bG96S3NGUFJucVhwUEhmeUtaOC9qQUtXUmRxSC8wY1l3?=
 =?iso-2022-jp?B?eG81bHp1RHI0TUJSZzNVeFc4WmNsYjVIZXViSU9XVDdMWUhNKy93c1h0?=
 =?iso-2022-jp?B?eG5JdDJqY3h5TmVVRkV1UnZjSDJvRWFKYkV3dUlQVXVUWE9UV0xxQlRD?=
 =?iso-2022-jp?B?OHNSNUlRUXdRejZONDdEeE5IZlBWVTdIcjNHY2xvUHROVnVhRnc3RHVG?=
 =?iso-2022-jp?B?ckN2ZFA1QnRKTjF6a0tmZDVUWnRSSWNlMDE0SjY5MlBZcUJ1bmFKQzQ5?=
 =?iso-2022-jp?B?RzE0VnBPQTFQUEFJR0pnaHFNRHpFTkl1ZHo1eDgwdjhwOVNXM1dQN2Zi?=
 =?iso-2022-jp?B?czlWRVpzOGNJcks2ZmNFSzd5OVB4ZjRmOUpTSzlIK3UyMUwyQ25qWXJH?=
 =?iso-2022-jp?B?aDR4WDJySjQ0Rk9HRk9aVXVrYXVYRWtMMmZWb3YxSm5qQTBBU2JaVW80?=
 =?iso-2022-jp?B?T1hPTFd6eUQ4U0hFZEZveDc5SUJHTFloaHNZeFdYU0V4bkkwOGdGcmJa?=
 =?iso-2022-jp?B?NlprVDZZQnRQbzVSNFBxM0R3TVRINU9oTXlNalBaaE9WTElZbkRYazc1?=
 =?iso-2022-jp?B?TlFVYmVjMm5ja251dkdHck1NWDBRc1AxMWxiUVRzNTFkRUc5eWZPRmF4?=
 =?iso-2022-jp?B?dnRPUmd1WEF6K2xYZHFQMC9zVFhienZGRDhpWGd3VnJMRFlick5hdE4y?=
 =?iso-2022-jp?B?S3E5WTlwTnkzZSt3ZVJJSnlNSFA0d1BmR3ZXQ3dPZVJKeXdNYytMU3pl?=
 =?iso-2022-jp?B?YnJ3eER1TEdZTEN1OG9Db05lZlRjYnIzM3A0YU9IS0d5bFRsMnk2SnNY?=
 =?iso-2022-jp?B?THJBNS9FcCthekZXbFVLUHB2UWh2aFBpdz0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YkRjSXhiZ2s0ZWN1ZkM0NU9pMEtBc3hDVVhGNXNFSjJJekF6OFZxSlZr?=
 =?iso-2022-jp?B?bEhGQnFNRE5keWtVbmZLTVFDR2FBNHFwNXRtTmlrZHJRZkNDN0ZaMnhJ?=
 =?iso-2022-jp?B?S1pMVUlUaWRDOEw1cm1RUForeFU1TFo3azJEUEZSZ09JSm15eElad2J3?=
 =?iso-2022-jp?B?Sk1aaU1jcmdicXkwcjY3ekJyY1ptaUwyOFFDdDJjcTQ5VXlWSXloZmds?=
 =?iso-2022-jp?B?ZVJFajdjTGV4YU5TeTB3RkplR3VZazArYTRsTGw2RXYyNXp5RDhwNVFk?=
 =?iso-2022-jp?B?NDJRUjRuRXpidTJVODFHNmZmTFp1cFJtR0VjN1ZKWXZmWWVGV0loRVhV?=
 =?iso-2022-jp?B?bzI5SVdGc1BhaVprczlZQXVCNGszRTBQaGxBcWprbndyRjdCL3VoSDVy?=
 =?iso-2022-jp?B?Z0c0NmlVZTNKci9oenJrZ1hoYmFDZWRKcjE2NWZBOGFaaUxjYVEyWnZk?=
 =?iso-2022-jp?B?VnZpak9MM09IS3dTZ0RQVzQ1NGQxMzFtZmEva0NISmkwOCsyRnYrVnli?=
 =?iso-2022-jp?B?bEc1WVNsSUxMWTZRUU1pZVp1NlVtcUN6REVvVHprUWpzRFR1eFM1ek5o?=
 =?iso-2022-jp?B?UmFEbk4za3cydHY0ZnpJSUhnQjBhbWU1bGVXRVQ5eGpNMUFuUjEydCtO?=
 =?iso-2022-jp?B?V2g3VzFWN2RMQVUxODNNWjFQL3FzOFBTdnN3SHFsdWtZMDF0WHRucW5P?=
 =?iso-2022-jp?B?bjNad3AxVU5Eb3JKeU9OcVN0KzBnNVBvSEkvZ3BTVUdwNzd1WXkyMXJj?=
 =?iso-2022-jp?B?c1VKV0pFbGFEcXJNS2c4QzJKL1lmQUI0b3c5WE1qNE1UMzdXYjhIZDYy?=
 =?iso-2022-jp?B?N2ZUNlVSSERBRk9wK0RyM0g4Q0hiRG1ES2NCQStpZUdNaFdhRkJyWWhV?=
 =?iso-2022-jp?B?ejgveXNYdU8ySVZ0T1BKc1NiK2JMVmRnZVNiTFprSGN5UW5TRC9MbHgz?=
 =?iso-2022-jp?B?YU5JaVBsUWVrNXlOVDNWaFZMd1dVYnoremxiWTRpSFNjcFRtL0hKTWRB?=
 =?iso-2022-jp?B?UitVTkpCUytxeDIyT3ZmdlB6ZkxHZ3ZENGhhQjFXYlYzbE56dHBLRmtQ?=
 =?iso-2022-jp?B?Y21LQnZucXp0UDFDMldJa0UyVnFGTmN0aGFGVm81ZlJ1Z1AzVVVYT20v?=
 =?iso-2022-jp?B?Zmk4V1hWN05DcHk0Wjd0dWhHTmhYcS8wV1Z3QXhETjNjWGY3MVZmMjNn?=
 =?iso-2022-jp?B?TG03aDZMdnNVdmpQUG9tWW9pekhFUFlaaldyUlB5K3Y4MS9CWEVQcHRq?=
 =?iso-2022-jp?B?L3lvOUFjMTJlcG15MUJibjJrNEFwNUtuYkFLK2NRKzhLYjFwd2p2N2Ux?=
 =?iso-2022-jp?B?M3BHYlUyOFdhbjVZeUtIRnl4NFBieFNCSFNxcTBRbk9wM3o2eWRlVEdi?=
 =?iso-2022-jp?B?MkRFTFRaa3ZTZDhvZlVHL0Z4bjV2amFwQTR3VHN5bzJyRTRhYjIzMVVT?=
 =?iso-2022-jp?B?YUJDYWFVRXNNRk15UEdETGVrOWxaYkhBU0pubGFKYUJib1cvSTBJOG9E?=
 =?iso-2022-jp?B?TjJnblJnbXRDclpSSUFSTENFVk9xOGtDRFIzZkJNSTFlcW83OUludnhG?=
 =?iso-2022-jp?B?czEraE16VVYwelZZSldHODBZZVUzN3g1UDJvaTZKT3RXcXZrRndjYTRI?=
 =?iso-2022-jp?B?WTJNVWsvQnJLblJ5UTkvZ0xjdGY5ZUtFN0cxRG55amxDYUVuNThlNEFC?=
 =?iso-2022-jp?B?TjdoNVR5WDhMYmZUYjBHMXZXR3BSMGFWWWZ0Zk9yTWgraDhkdCtSaGxl?=
 =?iso-2022-jp?B?NTZnbnp6NVcxUTJvMHJ5VkxrMmQwWW52UTNVTS9jcGZzSG82amZsSktM?=
 =?iso-2022-jp?B?MnlpVUp3dmRPcU16T2VoV3BBVTJMaERwU3J4aWtyNGtIOXhrY3h2emxr?=
 =?iso-2022-jp?B?TkVpVHlHQXJmWEd6Q3ZhOVNtMHZFcXpkb3RkMUJSNnBzR3ZSelpHbjVF?=
 =?iso-2022-jp?B?WHlrQ05WemhDeWN3S0NZY2dHVnV3bGlIaFBIMys5WVpTdHhFR21yMk1y?=
 =?iso-2022-jp?B?czBZSGRWOVkvMVZGNm1PTjdJU3ZpREoxTEFkVHlCRkRseFlkQ251TjdW?=
 =?iso-2022-jp?B?WmEwdWlmcXdIWnBhTkZkdWRabU55TXd0TXUzeXRPM21ZNlFzWFhWTTdp?=
 =?iso-2022-jp?B?SWtQNUh0RzlLL2FqQTkrNkZjR3VwZnduZHNiL1VySC93YmpYVDEvbHJY?=
 =?iso-2022-jp?B?MlhZcGh1VmlwVkYxUWo2U215ajBTQXVNMzRNY09Ednpxb2pLR0ZBWHFu?=
 =?iso-2022-jp?B?TlN4eWFHblEvOFZpS0dVOVFleGFtNjZzZ0lSYVMzdndlMW1VY2c0dXY1?=
 =?iso-2022-jp?B?ZnJhRm9Jc2hFbjNadk11WlpPd0tGcSt5a1E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc51cb3e-4b60-4a7e-c17d-08de161cde16
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 12:23:57.3611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y1qBItpRVpCvPo/WRXfsbPVFJCzx4SIeAUHovp9WSlnoXeqTmcnl8Mwa2VGgp4TPqonwJdWuTU2CpPVozU24Qvn0ABIIVAHay8VDGpY0o/kEzUtMG0ACmI6APxgbwX4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13803
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 12:24:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20260

Hi Quirin,=0A=
=0A=
>In my opinion, we should avoid build package from source. These packages=
=0A=
>will increase our maintenance effort of isar-cip-core.=0A=
=0A=
Understood, Thanks.=0A=
=0A=
And thanks for initiating the discussion with Bastian regarding the possibi=
lity of backporting the fix to trixie.=0A=
=0A=
Now if the fix is indeed backported to trixie, in my understanding it would=
 be available through trixie-backports (Apologies if I am mistaken).=0A=
Previously there were concerns about installing backported packages as they=
 receive best-effort updates.=0A=
=0A=
Thanks and Regards,=0A=
Adithya Balakumar=0A=
=0A=
=0A=


