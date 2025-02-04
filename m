Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A678BC02192
	for <webhook@archiver.kernel.org>; Tue,  4 Feb 2025 01:54:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.106136.1738634072834342510
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 17:54:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=ngUY6rnL;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1738634070;x=1739843670;bh=y7WVMTCGEgHi581fnh4++Z9lIoMAChf2seaBpb8
	XIpU=;b=ngUY6rnL7tiSZ30VIjpR813dYEOfTG2avA/N+jH7qsKy/1WPuMNKsjPC2dhbDaAcZ3T2c
	sisRSf1BQebH1vK536Pk5bdzIRa/Amc3BEdna9K3Yw70M9voonRQAZRt3ZtuVa7XC8iADu+CwcUh5
	HxacjR9ZW8sKu5doWPpofEn5Qazrt295lBWLH4jX0zjLXEgIytqrhu/dTDoXhL3v7Un6fm3GoOma1
	k/CR/QZvLyBbhz30BBx0AZ3SsTQuigmCFak23bSLvyxvskCY+dpVDWl4iL0Az0lEngNqyiwodWT0W
	/ha0ktePHW4c8f42tntDBXEowM6aMiZcXQZUhyDeVw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 5141sTAr184123; Tue, 4 Feb 2025 10:54:30 +0900
X-Iguazu-Qid: 2rWhg4sy0V9RxqpQbR
X-Iguazu-QSIG: v=2; s=0; t=1738634069; q=2rWhg4sy0V9RxqpQbR; m=m+pUcJ8V0wWEuziqfB8FoYymTFC1xf27X22F6PtP7LU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 5141sRa6377698
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 10:54:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3xtFb1FOwvwOapmBmjxgLVfYF/sdCDVZT0XFHWGwDeR4h0iPVQ2bt3v6mzf/lQb9rgVlht9P9UIkAkVaKeOViXj8NX8oPMq8l0mzrQYlZxXTIAXzvUBpt4fsmjmFQgz2qlRq6rQD6C1E9FHvsa2pX3H1IwVODY2X8xvId0PSz0La2iqcwvfisHiAGtIddWiU0hDUbFFADXAmx/PHoRPevO4qJ/bAaKazyF/nfAlt8qD8ViVCQKhOUmR+wj53cQH6E/U0APad7FSeuivfdm/8KAB2irQcauaFOsKVkwQaEuvPgGwWnY7CRuZU2G+nErnB+ipJak151dJfwKQ1bK61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//vvXdP1C8DEvRLy3pqeIyiZ/QPxuxflYpnm2G/y60k=;
 b=Lqq63F+Q6z2t+3Qz2yj1LNiiOYmUHMZTN76OJ4vL+YJbgQMPsfZUBA6j/3hWDyh8M3Ce06LZuTVUkwkSo2S1OXVlV3QJ4YjbGhoot6X30KnzRrDGXchEt0aKpTbzuqohf1h1gkn7fTHd9afQ6CuxS7N40+8Y0mVWX+bEdAgYm0EUgSkHukjKqEee+OWMVAD8k2S+sDmVVMfrwmueBzkAz+L+zdv5+dG4+IibLGKEr+6HYCH9h3Vk97lA4snXawNNxWNYhf5pYf1zyTzW4397WzToYQfuOUVDyg2sdx5bUsBvZXvj7WhDb8/9Tgy5qjETTe5kV+Qz5otKrlAeCyixzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzgBe04HoAA8CxzMAAdclSAAAvSl9ABozn5EAAHqe8AAK60BEA=
Date: Tue, 4 Feb 2025 01:54:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB113855148DCC369F848BE08F2E1F42@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <Z0mVe42i41SXemYu@duo.ucw.cz>
 <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z4o+Ue8yk1aDpmoC@duo.ucw.cz>
 <TYCPR01MB11385BAF7D5C56CC8CC378440E1E12@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5FPtY4aUHqMoL4w@duo.ucw.cz> <181D46DD0F426F98.25327@lists.cip-project.org>
 <TYCPR01MB1138502709ED426B37B76CAD4E1E82@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z5zP3BaPnG5x/d6/@duo.ucw.cz>
In-Reply-To: <Z5zP3BaPnG5x/d6/@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TY3PR01MB11554:EE_
x-ms-office365-filtering-correlation-id: 64090020-cfe9-4bcd-afd5-08dd44beda8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|7053199007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?amE5OVJuNGdVell2My91SGNIZUw4Snk5VkFlejdMYlhLYlAwOHRwUWFz?=
 =?iso-2022-jp?B?UUNFOHU5WlpDMFFRcGt3TTJnbE91R1kzYXltVDVGRjB1Sjg1cjJsWHg1?=
 =?iso-2022-jp?B?L1FMa0NMMWYxaExJaEpGdW9RTlovNjBMZzBuR3dzcHE3dkthSFRycjRM?=
 =?iso-2022-jp?B?bWptejMzeVFLVTRNeTA4QzZ1WTZXaTJHNm5pZjFVbzQ1dXh5MmVQdXVX?=
 =?iso-2022-jp?B?UDh3cURkRUJCZGJFSHBlWGhseWt4Y0tjQi9pOXVKckYvK3dzcXZldTN2?=
 =?iso-2022-jp?B?MlBIWC96R2xscm1PY29CUjliYlFkQ3R0dG41K0FiVVlsNjdyVGd1NW5v?=
 =?iso-2022-jp?B?UDV6RXc3OHpNWVRrbVVWakl2OVpYbEJRTzJYV1VoRkVlYS9uRXF6dDU2?=
 =?iso-2022-jp?B?clB5UmR3UVU5Z2E4Nnl0b1JlWXVOWE5EUXhqTk1wTHpuRjdaMk9oUHR6?=
 =?iso-2022-jp?B?L0NlOUI1ZFM2UDZ2bXVVdTlEM1JlUXRrUGJKTEt4MXlpVXdaWTFMOERM?=
 =?iso-2022-jp?B?elU5UVhYYllBaEVwSUp6SDIvWVVRY0tpcFYzZWg3cml0bG1CaTllbDg4?=
 =?iso-2022-jp?B?YkZoaFlNaE9uMUZNa0l0blllTHhoSVRJOVFHYlpsL0Fxd0ZhVWI4ejRE?=
 =?iso-2022-jp?B?TzF3MGd0ZVNvOVdiaTZvZGVvWGF1R0JJQ3gwMDVyNmRJbGlHWFJreGps?=
 =?iso-2022-jp?B?V1c0Z2xFS2FzN085aVJXSnY4NjRyV3QrVXBDeE5kMXMxZHJOM2hpZ1BS?=
 =?iso-2022-jp?B?SmFlN2Z2UCtIaVhOZWhoUTYzaTN2elBBb21HVXhYZE96WitieFN3dGpw?=
 =?iso-2022-jp?B?eVlOVUdnS0ozUWJFQ2FZWlZqblRQTEdPVmhtUExaeGVySnFUNEJ0QVN6?=
 =?iso-2022-jp?B?ZkVNWFN5bmlROXNYNEJEekJ0K2NsYmt6OFZPRCtMTXE0bHpiYXRacU1U?=
 =?iso-2022-jp?B?cHlNWE9ZalZYeTJiNmtseUtVVkphYVZVMzVqcCtOT0tIdUpjVW1TWVc3?=
 =?iso-2022-jp?B?Z2NZNndUcWd6NG5YVlc3aUExcVl0cy94NzVpZ01lTmFjSlUrY1d3cUVB?=
 =?iso-2022-jp?B?UjNQNlVvVnErT1dielVOYVVqL1dUcVJJM0R4TENlNnlVMzRPRW1VVVl5?=
 =?iso-2022-jp?B?Ulo0b1liaHo1ZUZXWi9EU2xvdXFxTHNRam85Z2F3Q3NiRDJuVFFUMTBV?=
 =?iso-2022-jp?B?YWQrdFZlR3k0TWpROGIra2pNa2ttQnY2ZE0xK293UUx5TVQvNW1taUMz?=
 =?iso-2022-jp?B?NWF6Z21PR0JOSWNTTURxNnp0UXJ4T1dLeUlaZEFjS3JQSENLd0VCazRH?=
 =?iso-2022-jp?B?cm02MVVpSjI4SU8yM0lmRTJ0ai9kOG9RUmxxVnhVRWluTjZsOG9Jc1c0?=
 =?iso-2022-jp?B?V3prOVpoOVl5dURjWnR0bkYyYTBFYUV2ODNFVEp6aDJZQk1wdFFOMG9B?=
 =?iso-2022-jp?B?ZFZCNjVKWUY2dFBST05KQVVHNFRVRHZrYjNmb1FVbHJuOFlzNExEQk4r?=
 =?iso-2022-jp?B?dnVXSlVPNXNvMmxDQmhhUVQ1R2pXN3p6L1pDK3E3V3VaRTRuZlBaZWx4?=
 =?iso-2022-jp?B?RisrU0RFMGs2MjV4bVgrYzIvLzFwNSsyNjNCeDNUTjArVDhkM1BuczdF?=
 =?iso-2022-jp?B?Z1U4ZWNaQ1cwVlFmejFwRUYxNXZYdS96d2ZYMXdYQ2tOeExuV1IzdzdW?=
 =?iso-2022-jp?B?SHk5VDYweG1SanU0TmVQdktkOElsaWFiQit4NDlwV3ZZWHh3UmlnWm9B?=
 =?iso-2022-jp?B?Z0pTZ2FhYWlnenU1N256V3FONXBreUs4SnNJSENJY3hFVWJRZGhvZVFn?=
 =?iso-2022-jp?B?dzlGZmZaVFllV2YvRGpmRHN2SGlIMy84Q0tpZ1g2K1h1dzgyUUZqSGk5?=
 =?iso-2022-jp?B?Z1Nha0hSVWl3SHRDbTZ2R1ZGU0VCUHB2azB6WlJpODQzNFl2YTd2Kzdj?=
 =?iso-2022-jp?B?NFlvMTRjRjhqMDJ0VlRsT2tsR29FYk1BSGlpaVBvZmdyc0VMTUE2ZHU3?=
 =?iso-2022-jp?B?MWx2dFp6NzZ1NW1xZytJdDh2S3BuVHF3TlZnL2s1SlUyVzZQbjhIREdT?=
 =?iso-2022-jp?B?Ny9aRjdaNDZFd2QwR1RvanpQcWlzRm89?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RUZCalFFeWFyUkNqYk1iaXE1ZU9oR1pHaGdhQUNCZE5RNXpMMk1tTk4x?=
 =?iso-2022-jp?B?S21ydzVnb2dSVVM2N2ZUNWVWME1UQUtXNk9WNG5HSTNmTGd5dmNCYVoz?=
 =?iso-2022-jp?B?M2NMUEorcXBDUUVmdHczZld1a29GQW82UGVrTU1hZGpHVTUvSE5NN1NO?=
 =?iso-2022-jp?B?Mmsza0VzNnZVTVZvV3VEWXJsQW1pV1VDTTBkcXhxYkliemh2MUF6WnRy?=
 =?iso-2022-jp?B?aHJPcXVUTWplT0N4aDhGMEdxN3FNQVBreU56TWdIYko2a0FZeEd2L1NL?=
 =?iso-2022-jp?B?dG1zZ2ROaWhUU0FCcnVrcFZMVUp0ZHhjaFpaOCtxS1RhalBrSGxRcDFi?=
 =?iso-2022-jp?B?SFhuM29mcVdEcGErUWg5RS9qUG9DNW4vWFdsOEhoSnJWN2lrVlhQUmJB?=
 =?iso-2022-jp?B?TFZTRmtFUjhLLzZDNjZIV3NONFZIK3FRc0M4dDZqTXl3ajROc0V2eDlz?=
 =?iso-2022-jp?B?M01kMjNabGEyQzBRWVA0NE9vY3BYNEt1N3VVZllhZjNlZnZqWlZpbkdW?=
 =?iso-2022-jp?B?eDg0S3ltcnFqcWJ6SUY2Z2hUOXNBdlhjSnBnL1Y0a2F4c2JLWUZmUHBZ?=
 =?iso-2022-jp?B?UCtvUVV3TzM0RnNHcHNScGpBdGdHYVdodDJXTFptQ2hKbzJQMmdsTTdP?=
 =?iso-2022-jp?B?NzFmUGhWd24rZmpnRk5PVTdkQm50STg1dEl2c0lSRUlaSi9qdFU3d2Vm?=
 =?iso-2022-jp?B?c2dyaXlEd0dpOVdIaXY5NnI2OS9YeDMrZFVYZERrc0YzZjJ0UUxrWldV?=
 =?iso-2022-jp?B?UVRoeGtJV3M4WHJKajJNc0RmNHpXRHJVcElueCt1Rm9JOTlGZWRVY0pH?=
 =?iso-2022-jp?B?TU4rY1dwYkZHQlF3UjZ1eVRUQ3pHcFBDL2Qrb0NpUWpabkxoT2pRa1Ev?=
 =?iso-2022-jp?B?aGNXYTNQU01pamxTcjNKb1VWQWVNVThkTTF2UU5HRnJJUXpEbmd3VlZ6?=
 =?iso-2022-jp?B?Z2h4ekQ1L0dhRmI4WFlsWXNlck1FV0wxUVhTeCtXRUMveUxtdm4zRmdS?=
 =?iso-2022-jp?B?aEx6aDhCNkhBNGJrVnRqQWoxTEsxTUNtVUpXaHlPUW9QODdBOElSY2RR?=
 =?iso-2022-jp?B?SjZmeVpieVBKNVowSDJETVRKUU1nZmlJWitQak96dEVwTWlJQnBmNUMw?=
 =?iso-2022-jp?B?MVpUQzA5RVhGSU9MQ0R4cGVzSzN6YXlSYWE1R2NMdkVPMHJ1bFB4Z1JH?=
 =?iso-2022-jp?B?SEVGRVdORmRqSml0ckxPcmJCUVgyQTZSZE8vNCtLVlVTOWI2Q2ZrSm1u?=
 =?iso-2022-jp?B?R2ZNN1ZwUFVMMVdxbTlkOGVaV0lFWmpFRU1yZ0x1b3VtL0Y4MzI0RjQ2?=
 =?iso-2022-jp?B?d0pWWkFkTkRyb2FtODlBQkwvb2xuN3UrNjBjaS9GOWFlYTBBSVZrSi96?=
 =?iso-2022-jp?B?NUVyOTJ5TmNWZDUzbnlEUWRDeTZRSUsrOUVpMXpTeEFjaWVpakQxbm0r?=
 =?iso-2022-jp?B?SFR6TE00QWR0WHpSenJQbTY3Ti9ESUx0ZnB3OE1wd1dpT2d2VlRTL3RD?=
 =?iso-2022-jp?B?MlErWStOSUFmWVBOUEFWV3NIUmVlVTlpRkZvMVYrU25YVlVRcUJuV1o0?=
 =?iso-2022-jp?B?Ri9PRTZzc05wRnNuYUhMWjZBMVA1V1VCYU4xcjhyRnBJYzY2eW1JRjhX?=
 =?iso-2022-jp?B?RFFWTzErR3ZZN3JqREN0UkVob2xhY0tORnl1em5qZDV4VDd6YmFqU0lU?=
 =?iso-2022-jp?B?WEhUcW5yWmRxYU5pU0xYakhTb095eTdlRjlWVCttSUVpdWQ1QWdoSUhw?=
 =?iso-2022-jp?B?T1VnRWxCS242VHMvQkJqRWhrV3NPL3lnM2tmTUQwZGc5cVZzTGRqMFlE?=
 =?iso-2022-jp?B?ZkVOYmYrVE5yd2pBaE5QUTY5d2RVeVMyNStTc0RXYWpuNEdPU1lpOUdN?=
 =?iso-2022-jp?B?TmxtVUtBbk9HaWpqU1ZQMzJhdHpZL2VDZjR1YWVRMkhXRGh1NW1wKzA1?=
 =?iso-2022-jp?B?K1N5VlVVMEYwTGM5VXNHS3YxYmR6ZDlnUlZYbjJtOThHNnFKNW5HbU5Q?=
 =?iso-2022-jp?B?VVBsWWlEa1o5cnR5RTduaFIyeXVjSVZTWWMwWk8vWkcwbjRQVjYzak93?=
 =?iso-2022-jp?B?Ti95aHdLVFdHQkdlL0Q1MW9iM28rOCtNTW9sa1Q4WEx6ZlVWSU92Y3dm?=
 =?iso-2022-jp?B?NGNoeDFXcjJWM1NsS1crdmJXN0F5Vjc5dnZnWGxwR1ZWWERrUDdqUmY5?=
 =?iso-2022-jp?B?VnVmYU93ZUxxSy91Rm1kU2twSCthS2FqbjNYalUwNXppSE5aMG1KUXlI?=
 =?iso-2022-jp?B?QVNMNEdDTFZCRkVRVk9JOUd3bnFsZVFpbU4yRHNMZC8vaVZmK2FzNGlk?=
 =?iso-2022-jp?B?cHd1dU5SKzdyRlNKZTd2RGExVnZTeTY4aWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64090020-cfe9-4bcd-afd5-08dd44beda8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2025 01:54:25.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQ9KlQ5jIQ3XWuB7Wh/bAbBmLx0h5tj402IYG/P+BWtq6sc97QnLuVO0cPq3ZrauDwsw7S5C7J9KeCQhphaysxCi6a7n5gpxHao4ekrIOxFK7iwQARdnkxIPfHF1dW7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11554
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Feb 2025 01:54:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17742

Hello Pavel,

Thank you very much for your careful check.
I have updated the patches following your comments, then submitted to the l=
ists[1].

However, I could not find the posts in archives except cip-dev.
https://lore.kernel.org/cip-dev/1738629964-11977-1-git-send-email-kazuhiro3=
.hayashi@toshiba.co.jp/T/
https://lore.kernel.org/linux-rt-devel/
https://lore.kernel.org/linux-rt-users/
https://lore.kernel.org/linux-kernel/
Is subscribing to the lists or anything else required in order to post?
I was thinking nothing needed [2].

[1] https://wiki.linuxfoundation.org/realtime/communication/mailinglists
[2] https://subspace.kernel.org/vger.kernel.org.html

Best regards,
Kazu

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Pavel Machek via lists.cip-project.org
> Sent: Friday, January 31, 2025 10:28 PM
> To: cip-dev@lists.cip-project.org
> Subject: Re: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in unpin_cur=
rent_cpu()
>=20
> Hi!
>=20
> > > (1) Apply 0001 - 0016 to v4.4-rt and v4.9-rt (but not acceptable for =
-cip-rt)
> > > (2) Implement another flag like "system_is_scheduling" above then app=
ly it to
> > > v4.4-rt and v4.9-rt (Again, no need to suggest (1)(2) to v4.14-rt or =
later because
> > > SYSTEM_SCHEDULING is already there)
> > > [...]
> > > First, I'd like to make a draft of (2) then confirm the repeated WARN=
INGs do
> > > NOT occur with that.
> >
> > I have created the patches (2) based on your idea.
> > Please check the attachments then let me know if you have any comments.
> >
> > I confirmed that the repeated WARNING never occurs with the v4.4-rt + t=
he patches.
> > (20,000 reboots on VM, 7,000 on x86 64bit machine)
> >
> > If no comment, I'll send the patches to both cip-dev and -rt lists.
>=20
> Thanks for the series. Code looks good to me.
>=20
>=20
> > Between v4.14-rt and v5.10-rt, allocate_slab() is responsible to enable
>=20
> "to enable" -> "for enabling"?
>=20
> > IRQ before running the following slab allocation functions if
> >     system_state >=3D SYSTEM_SCHEDULING
>=20
> slab -> SLAB, more than once.
>=20
> > However, SYSTEM_SCHEDULING is introduced[1] in the mainline v4.13 and
> > it's not comfortable to backport all related changes into older RT kern=
els
>=20
> comfortable -> reasonable?
>=20
> > from functional compatibility and longer term maintenance perspectives.
> >
> > Thus, as an alternative (but not-mainlined) way, introduce an extra fla=
g
>=20
> not-mainlined -> non-mainline
>=20
> > "system_scheduling" which becomes true at the same point as
> >     system_state =3D SYSTEM_SCHEDULING
> > in the mainline so that the existing system_states and users of them
>=20
> "so" -> ", so"
>=20
> > are not affected.
> >
> > allocate_slab() will use this flag for its IRQ control by the upcoming =
change.
>=20
>=20
> > +++ b/init/main.c
> > @@ -110,6 +110,14 @@ bool early_boot_irqs_disabled __read_mostly;
> >  enum system_states system_state __read_mostly;
> >  EXPORT_SYMBOL(system_state);
> >
> > +/*
> > + * true is equal to system_state >=3D SYSTEM_SCHEDULING in the mainlin=
e.
>=20
> "true is equal to" -> "This corresponds to"
>=20
>=20
> > This patch resolves the problem in 4.4 & 4.9 PREEMPT_RT kernels that
>=20
> "the problem" -> "problem"
>=20
> > the following WARNING happens repeatedly due to broken context
> > caused by running slab allocation with IRQ disabled unintendedly.
>=20
> "unintendedly" -> "by mistake"?
>=20
> > [Problem details]
> >
> > On PREEMPT_RT kernels < v4.14-rt, after __slab_alloc() disables
> > IRQ with local_irq_save(), allocate_slab() is responsible to
>=20
> "to" -> "for".
>=20
> > re-enable IRQ only under the specific conditions:
>=20
> "re-enable" -> "re-enabling".
>=20
> > (1) gfpflags_allow_blocking(flags) OR
> > (2) system_state =3D=3D SYSTEM_RUNNING
> >
> > The problem happens when (1) is false AND system_state =3D=3D SYSTEM_BO=
OTING
>=20
> "SYSTEM_BOOTING" -> "SYSTEM_BOOTING,"
>=20
> > caused by the following scenario:
>=20
> > 1. Some kernel codes invoke the allocator without __GFP_DIRECT_RECLAIM
> >    bit (i.e. blocking unallowed) while SYSTEM_BOOTING
>=20
> "invoke" -> "invokes"
> "unallowed" -> "not allowed"
>=20
> > 2. allocate_slab() calls the following functions with IRQ disabled
> > 3. buffered_rmqueue() invokes local_[spin_]lock_irqsave(pa_lock) which
> >    might call schedule() and enable IRQ if failed to get pa_lock
>=20
> "IRQ if failed", "IRQ, if it failed"
>=20
> > 4. The migrate_disable counter, which is unintended to be updated while
> >    IRQ disabled, is accidentally updated after schedule() then
>=20
> "unintended to be updated while IRQ disabled" -> "not intended to be upda=
ted with IRQs disabled"
>=20
> > The behavior 2-5 above has been certainly obsereved[1] using ftrace.
>=20
> "certainly" -> "".
>=20
> > The condition (2) above may intend to make the memory allocator
>=20
> "may intend" -- ??
>=20
> > [How resolved in newer RT kernels]
>=20
> "How resolved" -> "How this is resolved"
>=20
> > [How this patch works]
> >
> > An simple option is to backport the series[3], which is possible
>=20
> "is to" -> "would be to"
>=20
> > and has been verified[4]. However, the series pulls multiple kinds of
>=20
> "the" -> "that"
> "multiple kinds of" -> ""
>=20
> > functional changes like SYSTEM_SCHEDULING and adjustments for it,
> > early might_sleep() and smp_processor_id() supports, etc.
> > Therefore, this patch uses an extra (but not mainlined) flag
>=20
> "mainlined" -> "mainline"
>=20
> > "system_scheduling" provided by the prior patch instead of
> > instroducing SYSTEM_SCHEDULING, then use the same condition as
>=20
> "instroducing" -> "introducing"
> "use" -> "uses"
>=20
> With those, you can add
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


