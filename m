Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5F3D6DDFA
	for <webhook@archiver.kernel.org>; Fri, 15 Nov 2024 13:44:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.20964.1731678289741328265
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Nov 2024 05:44:50 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4AFDilwW971924; Fri, 15 Nov 2024 22:44:48 +0900
X-Iguazu-Qid: 2yAbFMcPNndCwoGetk
X-Iguazu-QSIG: v=2; s=0; t=1731678287; q=2yAbFMcPNndCwoGetk; m=eEkIdRUWf4gLcDmKD4zC+93ne8w48ME69drHPwsF05I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1802) id 4AFDikRL3384023
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 22:44:47 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZFFktzO51RUKq57tAtCaUMsQHVzxxOBkbTD1v39PYed9/LAzo1TRx4MYIvFlJqqoQWIVDlcJGsVPcNqdFGlSBZazclBfgqkWZpHpPJVgGgS6440km7ArdigNDK2InZzjAx5/M1hRy8lguSAcK37mxU9mRjP4FvXCix7GzLQdKflk+7v2xvPouKTW+eh/6s5M1WRdBXXYT6hBy1PzTB8QLijJnGuWhnpUrba9McbzqG0ItsMI6uK1oURDGSPsVzG687p4155ajIPWgod5nR58xsw8veFgZ2qZ78uu5D1nxHUz30pfB48gdaYii6EXWW7YxhwG1x36HN81AhNu+rW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piEfzz18GXH/ViJ2D2g6hpGyHY4WOqKUaa0orpp2RIE=;
 b=edUFW6Fu2hfDpsbGeWrFi+QBNkjzofMeSAXb84N5mCnVbfMVSeDNep7aBitAkZ2MYmYoNF0Iqu7pGvGuJzHbEhe9YPLCeOYRjmOfTyXxDkdhaydz+Adndn1rHUS9fFu4ta2UZr08fkaoMPGYBMCvDy+HL/J7/+Lc+/oKDHUWN6voSE9Jq0kS7nFWB65D3q8BQm2TCNAGj31GLBQ4I5Fo55k2XelzwIPJUq4igKKOb38KdNIkzR5M5NUboihwkyJxUnYDAjR0ediuqMxrnjrQAVBaDfKSu6q5Dsbu3KyYUEOTPxw0jaTgpsyYKZL/GYPnHLWYDtey9EDUpSpcGr2raQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <kazuhiro3.hayashi@toshiba.co.jp>, <dinesh.kumar@toshiba-tsip.com>,
        <cip-security@lists.cip-project.org>,
        <nobuhiro1.iwamatsu@toshiba.co.jp>, <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Topic: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and
 generate results
Thread-Index: AQHbNLcv3vC8deZB0Ua07zkQ6b5nXrKzrb4QgASohfY=
Date: Fri, 15 Nov 2024 13:44:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61037D6982A3F30EA4F12CECC2242@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AC4F03F328776A6DFBCBC2592@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYYPR01MB1240281691D569EB3FFF1BF46B7592@TYYPR01MB12402.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB6245:EE_
x-ms-office365-filtering-correlation-id: 7cb09348-220e-490f-c618-08dd057ba879
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?cWtYZS9BOVR5L1l4Um1rbktPR1crME55cGhuNGRYL0JFZWhTeXp6MzFw?=
 =?iso-2022-jp?B?SWEyc1NOdXdLbFBiVWo4TWpucngzd0UrSVJpQVJGanVkbytLMjB3MGZa?=
 =?iso-2022-jp?B?OHdyV3dUZXNEM2hPVldjTmRKcHJEWU9CYTRsWi9TT2lYMXREZ25TZUZk?=
 =?iso-2022-jp?B?OTZxbmVBU2VSLzg2cVdmSFU4YzRhcXM4QTVzM25EZXdtSlNvTDE1WEsr?=
 =?iso-2022-jp?B?N1VyNG1jZnpFUSt1WDhHb0J6MDhqa1p4aUQ2VmxGdm9KcHFvNFA2Z3pQ?=
 =?iso-2022-jp?B?WWtEMTR2UkhUbzcyYTBTZ3dJUDljS3ZlbDJkZitmd0RIMjhSdGRXdXFJ?=
 =?iso-2022-jp?B?ODRFVDloZFBKaXBMcXRUQStNTzhOaUtZNWl2VGNpSU80NCtaU0IxRWtP?=
 =?iso-2022-jp?B?dExGVW9ycHhKSkN2L2JEd0MxVUwwem81MkR3OVhYWU00UmhyOUYwbG8r?=
 =?iso-2022-jp?B?NzQvZnduczZvdWoyQkxQUVlLZEdISUFiR09TQnJKRVAzYzNhRGoveEM4?=
 =?iso-2022-jp?B?ZUJURGNZQ2dOYW5DQjFyUjRUL3ovYlZkUEtiOFBleVdTRkpXNTdwaklq?=
 =?iso-2022-jp?B?eXBYRWZla3dKRUY5Q0M3QzlYRFZCNHBPUTlIK2tXKytCU0hjREVXRXkr?=
 =?iso-2022-jp?B?ZVowVjN5UDJYRmtLbEtMRzRGblh3UFZyQmkvaFlFaTlEOU1qeWs2SzVJ?=
 =?iso-2022-jp?B?aytxREtLT0xaTzFDaEdBaXNnTGZHOVF0RjJYSWZvcjlDekk4dmlMWncy?=
 =?iso-2022-jp?B?MWlPelB6WGxESGJ5RkYzWFZhTHFHR0J0UzBEbjE3MlhROGJJVVAwUEFt?=
 =?iso-2022-jp?B?dGdlYjM0WXZRblpxY0I1NTNxNzEzRDBoem5pQUlIaDE4a3A1TjEzSkth?=
 =?iso-2022-jp?B?ODlWZXVNTnJxbThkQ0JDRlhyeEZHOUw0dW8vSHZQdXhZMW9UOEJoVmhi?=
 =?iso-2022-jp?B?MDdHNG0rYStKcDM2OWFSNGpWWnNBKysxalFJVDNMb1QvR0ZaeGd5bWJr?=
 =?iso-2022-jp?B?Q21IODBzZkxLU1AwNkIrWlNZZVVSdE9SYThDWDllZG9FV2ZLZkJzMlM3?=
 =?iso-2022-jp?B?RTlsMHJJR1hWZmFmQ01BY2VvYzh2WENxREl3WkJzSnMzKzVYd3B0eGJu?=
 =?iso-2022-jp?B?dFBNRzVaZ0x6R0ljamxBeVIvUjRibXhja2dydkswN0Z3NU1ESWlTZ3NZ?=
 =?iso-2022-jp?B?eUhyYXVCcHZPMjJNbTJzREJsYlhkSUJsK2ZwUTY1eGVXMGZpS0h3aWdV?=
 =?iso-2022-jp?B?dE0wb3lVUnk5NlVQekxCZzFoT1NZeGtFWGpIbnNtaWdRc1haREhteTdw?=
 =?iso-2022-jp?B?aWExVEs0dEZRTHgwNlY2VlkwcDlXUFdabG8zTlNxZTE3bXdrZ2V6Zkpo?=
 =?iso-2022-jp?B?VDR1YTYzTU9zYWhlUE1rbzBSY2hRSnlEbjVrLzhzZ2R4aFhwZnJUUHg5?=
 =?iso-2022-jp?B?Y3Bhd3dzZXRKRnhSUFVONjlCajN5QlZQa0NkcmF6NmlKUkc5WmQ4RGZP?=
 =?iso-2022-jp?B?SUx4aVh4aVpjdHRzTDgvT0JhalJmWmpqTFdRTXBSTkxuWjk0eEsweVd4?=
 =?iso-2022-jp?B?QW9TTjlsQW9BMG1wWW9vZFEvSTlIT2tFdFNyakJhUTBvZDlaZWhONXpS?=
 =?iso-2022-jp?B?dTI3NEZ1Qjd5SWhRN0hZaStNQm02WUlSeFJVMDZBekIwUWpEeEFieHIy?=
 =?iso-2022-jp?B?WGFqT3NxUDVvWUZ0SGxoV20vNnV2RVlVUDA0ZldGV2dGbFhMVW1zRFMr?=
 =?iso-2022-jp?B?UVcyWEVxcndMQjJWamU1ZnVIMFY0RXBDUC9IM2EyWlJhSzdXbGZtWDFL?=
 =?iso-2022-jp?B?eDdDYytGY2p0NVlBaDc1VDNoMFA0SHVkTXJUTnRIVWQrcDMxMklWejlX?=
 =?iso-2022-jp?B?QytEYVczQjVMOTBvMmdDRitRcDl2dWdNN3dUQ2QzdCs0MWdpSVRxcWpn?=
 =?iso-2022-jp?B?eVNBOFZiVGNkVjI3OFFGMmdqUThwQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SG9JV3hqdGNhd3hWYVowRTlRU1pvQk9mQnE1eXJiMVVINFVIdndRck4y?=
 =?iso-2022-jp?B?NXlwaENLRlI1QWxiUzFocWFPNU0zbW9FUWhOSTlsMmJkdUlDMGNkeWxJ?=
 =?iso-2022-jp?B?MHRObkhrWGIyZjk4Wnc1Zi85aVdFOGVva1FUUUdUd2hxSlBiNG5zaW1x?=
 =?iso-2022-jp?B?b2FvQnVSYjZEbXA2SzNPdFJ2RXVQUTkxaWNpWS91RWVRTVVtMUVFT0dX?=
 =?iso-2022-jp?B?OU50VDBVNkZCa0ZSTmtmTGVQczNoWjlrL1RvRHh0YTBxbldHekVHZUhX?=
 =?iso-2022-jp?B?dnN4a3VlamZJNTU4ZmFFa1pyUUxhNEVqVm1JT21vMnlucUJBODJ0bm8y?=
 =?iso-2022-jp?B?MXVzUjBKeWJZOFpDWXBMeHM3Nm4rVWw3RjI4MDFqZnlNS1Nrd2dqeUVN?=
 =?iso-2022-jp?B?NkFUb0FDM0k3WXV3dGx1enllSFZiKzcxTVducTVaR2hTbCtIZ0JLWU93?=
 =?iso-2022-jp?B?UFc4aTM1MFUzWjNWVUhRZ29nR05ibWhkb0hReG16S1hUZjJubGo5SFJP?=
 =?iso-2022-jp?B?RjZhdXl6eGJmSzhvYjd0VkdWZUV4Y3VrYjk0anhvYkd3ZUxkRUJyL1RJ?=
 =?iso-2022-jp?B?cW5HdXpHRk45TXdhbG1ZU0poSlR0TXA0ei8wMk84dCtoMjgvcmlCeXh3?=
 =?iso-2022-jp?B?RXA1OGpSS1BJWUZ1c3V2YU9kL2xyQ3p0dUVaYkRXYXQxbFR1cXdHZmRV?=
 =?iso-2022-jp?B?ZjJJc3RCY1UwTDhqSDgwWXQyYkJ6S3QvdDRyY0VtOFNONENzS2gwN2Yv?=
 =?iso-2022-jp?B?MC9zRUN3QjAwRzhabGJPV1lhb2t3ZjhyemgvVENoZWx5N21uTHVVZmY2?=
 =?iso-2022-jp?B?SDgyVUsrcUs2WmpwWnFvUnQ0eHRCckM3TjBlT2NyWlVyRTRYdmFBSW5k?=
 =?iso-2022-jp?B?WFhFQ0VmWnQ3eW13TTZ5bzUwRENDTGNhNDhNQlgxUi9PemFtTlZCZE80?=
 =?iso-2022-jp?B?eHFRSUYzQURlanV5bU01UFd5bHpsdFhiM2hoSThMT2hUS0VvU0hJa2pB?=
 =?iso-2022-jp?B?eXVYTk5kTU5PaW9rVEtVYWE3MUx3akpwM2VTZ0FEUUV3cDAyWmMzWG42?=
 =?iso-2022-jp?B?cmNicGlpZDQrZFlEYjVTRWUvWldNYmdDb25ZZVNpTGxyRU9GdVZxTkl0?=
 =?iso-2022-jp?B?b0Q5N3RITU51MmpiNVV1UlFabjBWMEJvL1ZIeWhaMEIwN01UWGxlNXJI?=
 =?iso-2022-jp?B?MWxyVWI1cVBQb0RSYkNRNXVoNFpoNGNjbHhaOEpuV1dtczF1bVh6Ym56?=
 =?iso-2022-jp?B?by9tMyt4ZTlkR0V1K3JLSGdUQmhoNHBESHIzcjNXN1JWdnp6dmxCeEl3?=
 =?iso-2022-jp?B?ZzE1aldjZE02aEFEWXZaRWJOQkxNQk9aeWNDSTRVejU5a2Q3Z1BYYzNv?=
 =?iso-2022-jp?B?bHprSTM5R3pONFFQUnV4YTB5U2cwdmlRYXNXYWJLV2JLVUI0eFIwWkc5?=
 =?iso-2022-jp?B?MG9iQTJGZ1J0ek9aU2RXSGkzNWFUdy9hYXIwcTl2NjJIRndLeFpBUjhQ?=
 =?iso-2022-jp?B?Q21uaFRFR2YwSkU1V1RVS1NXZDNqb1hKVjFMWXAxbFgyS0hBUWE1b0dl?=
 =?iso-2022-jp?B?YWZsTklHYzRiYXFkaEJoWHUwVFFYNkNyQVRVR1Z5TmRQaUlIejdzZXJh?=
 =?iso-2022-jp?B?QlpjMFQ0YTA2SERnNzZ5RzBBMmRJVWNLdHNWQVZmT2gyeUwzRlRmRW9H?=
 =?iso-2022-jp?B?V0NFTW53NFo0ZlNLQlRKUElRa2pRM0pzVm1mdVM2aWVVOTFEck5Ud2FE?=
 =?iso-2022-jp?B?bkxQODBNUloyeW0zK2E0UG1RTXVNNjlucDVxRVIyYmhrTVJQNDhlelFM?=
 =?iso-2022-jp?B?bzRJQWN2TFdUM3FTamowdUhxWVBFVmp3dmsyQlNHeEQ4MGNTTlVwMkNP?=
 =?iso-2022-jp?B?RWpnWHp6ZWF0S0N1OXFmNW1hRy9zNzB0TXNZMEdZTXNMR3ZmNFdlNjBt?=
 =?iso-2022-jp?B?RUlYbHZPemd6TUkxVEM4ZmJES3RHUTdTSGZxSmZ5aUk1WGdqRTdsZmJ1?=
 =?iso-2022-jp?B?aSttTzhIMGh4NGZBWjdtRm5jeThvWHpyVDRrMEVjWHM1TmlIQ0Q5OHlD?=
 =?iso-2022-jp?B?akEvY3ljQktLeFBlSTV4Q3ZlK1IvOVhUZ29BUll4NUhUbzIxRVFyR1pw?=
 =?iso-2022-jp?B?UzVnN2VKRUhiVldjaDF5akRScklnV1FZQVpmWERqZDY3Nnc0V204NDhk?=
 =?iso-2022-jp?B?OGhHSjBKc0xocUMvVndRaEVRTXVCc1dIQkM3NWI2eTY4dGpEUGMyeEd2?=
 =?iso-2022-jp?B?OGdocVpLUHlyZm9uZHJUa3ptemNDcU1hczA3RWFpWGR3Mmg3NzdEUTl5?=
 =?iso-2022-jp?B?WmdxV3hPTnE2Sm1zM0ZUUkV4WWxlT1o3eXc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB61037D6982A3F30EA4F12CECC2242OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb09348-220e-490f-c618-08dd057ba879
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 13:44:42.1963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hWsIQ9hYHbkjnZYuWVMbnFYDDdtqDXO/mAZVCWMrCqnWQmB/9FXJvkxZLHXt9oA6oiQFeEsMnGWUoqj3ny9dVUVOfsGyMa7ONi1xBtZBSbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Nov 2024 13:44:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17258

--_000_OS3PR01MB61037D6982A3F30EA4F12CECC2242OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Hope you are doing well.

After going through Lava job definitions where ltp tests are run on CIP ref=
erence hardware on CIP LAVA,

I noticed that ltp tests are being mostly on:

renesas_r8a7743-iwg20d-q7
renesas_r8a774a1-hihope-rzg2m-ex
x86_cip_qemu

Using rootfs tarballs such as:

https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz

..along with respective dtb files.

But currently m-com health checks are using https://s3-us-west-2.amazonaws.=
com/download.cip-project.org/ciptesting/cip-lava/rfs/rootfs-simatic-ipc227e=
.tar.gz rootfs.

I tried to use  SKIP_INSTALL: "false" in the test definition because ltp te=
st cases are not present in expected folders, ex: /opt/ltp and dependency p=
ackages as well expecting they will be installed in the image after boot. B=
ut the job failed. https://lava.ciplatform.org/scheduler/job/1223149#L1339

I request you to help me in preparing a simatic-ipc227e rootfs tarball with=
 ltp tests and required packages and pushing cip-project s3 storage so that=
 I can run ltp tests on m-com device. Please suggest if you know any altern=
ate rootfs can be used to boot on m-com device.

Thanks and regards,
Sai Ashrith

https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz




________________________________
From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> on beha=
lf of Chris Paterson via lists.cip-project.org <chris.paterson2=3Drenesas.c=
om@lists.cip-project.org>
Sent: Tuesday, November 12, 2024 7:39 PM
To: cip-security@lists.cip-project.org <cip-security@lists.cip-project.org>=
; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{=
#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>; hayashi =
kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S=
!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=1B$B#T#S#I#=
P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com>
Subject: Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x86 and g=
enerate results

Hello Sai,

> From: cip-security@lists.cip-project.org <cip-security@lists.cip-
> project.org> On Behalf Of sai ashrith sathujoda via lists.cip-project.org
> Sent: 12 November 2024 04:14
>
> Hello Chris,
>
> Hope you are doing well.
>
> Regarding IEC 62443-4-2 certification, the certification body has asked
> for Kernel and IEC test results on M-COM device. Based on my current
> knowldege, I believe that the test suites mentioned here
> https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55 <https://gitlab.com/cip=
-
> project/cip-testing/linux-cip-ci/-
> /blob/master/submit_tests.sh?ref_type=3Dheads#L55>  shall run for every
> updated kernel image on different CIP reference hardware in LAVA.
>
> Since availability of M-COM device on CIP LAVA Lab still needs some time,
> we are manually running each test suite i.e SMC, Smoke, LTP etc. from
> https://github.com/kernelci/test-definitions

As Jan said - we now have one in CIP's LAVA.
If you have issues using it please let me know.

>
> There are no issues with running SMC, Smoke tests but while running LTP
> tests it is trying to install some dependency packages to the root file
> system. Currently it shows it is a network issue but even if it gets
> resolved, the packages cannot be installed because the security image has
> read-only root file system.

So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.

>
> Another idea which needs to be discussed is, since Kernel tests by name
> means focusing on testing only the Kernel, we can try to use a different
> root file system to run these tests. But this is just an idea, this needs
> to internally be discussed within SWG and with Certification body.

There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.

>
> I request you to provide any suggestions regarding the attached LTP
> issues.

You'd need a working internet connection to solve the specific issues in th=
at log.

Kind regards, Chris

>
> Thanks and regards,
> Sai Ashrith (T S I P)
>

--_000_OS3PR01MB61037D6982A3F30EA4F12CECC2242OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello Chris,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hope you are doing well.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
After going through Lava job definitions where ltp tests are run on CIP ref=
erence hardware on CIP LAVA,</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
I noticed that ltp tests are being mostly on:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
renesas_r8a7743-iwg20d-q7</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
renesas_r8a774a1-hihope-rzg2m-ex</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
x86_cip_qemu</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Using rootfs tarballs such as:</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
..along with respective dtb files.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
But currently m-com health checks are using https://s3-us-west-2.amazonaws.=
com/download.cip-project.org/ciptesting/cip-lava/rfs/rootfs-simatic-ipc227e=
.tar.gz rootfs.</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I tried to use &nbsp;SKIP_INSTALL: &quot;false&quot; in the test definition=
 because ltp test cases are not present in expected folders, ex: /opt/ltp a=
nd dependency packages as well expecting they will be installed in the imag=
e after boot. But the job failed.
<u>https://lava.ciplatform.org/scheduler/job/1223149#L1339</u></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
I request you to help me in preparing a simatic-ipc227e rootfs tarball with=
 ltp tests and required packages and pushing cip-project s3 storage so that=
 I can run ltp tests on m-com device. Please suggest if you know any altern=
ate rootfs can be used to boot on
 m-com device.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thanks and regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sai Ashrith</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(255, 255, 255);">
https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/cip-testing=
/lava-healthchecks/rfs/core-image-minimal-qemuarm64-ltp.tar.bz2</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(255, 255, 255);">
<a href=3D"https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/=
cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz=
" id=3D"LPlnk343694" style=3D"color: rgb(255, 255, 255);">https://s3-eu-cen=
tral-1.amazonaws.com/download2.cip-project.org/cip-testing/lava-healthcheck=
s/rfs/core-image-minimal-qemux86-64-ltp.ext4.xz</a></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<div style=3D"font-family:Aptos,Aptos_EmbeddedFont,Aptos_MSFontService,Cali=
bri,Helvetica,sans-serif; font-size:12pt; color:rgb(0,0,0)">
<br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> cip-dev@lists.cip-pro=
ject.org &lt;cip-dev@lists.cip-project.org&gt; on behalf of Chris Paterson =
via lists.cip-project.org &lt;chris.paterson2=3Drenesas.com@lists.cip-proje=
ct.org&gt;<br>
<b>Sent:</b> Tuesday, November 12, 2024 7:39 PM<br>
<b>To:</b> cip-security@lists.cip-project.org &lt;cip-security@lists.cip-pr=
oject.org&gt;; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#=
T#C""#D#I#T!{#O#S#T=1B(B) &lt;nobuhiro1.iwamatsu@toshiba.co.jp&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org &lt;cip-dev@lists.cip-project.org&=
gt;; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#=
D#I#G""#M#P#S!{#M#P#4=1B(B) &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;; dinesh=
 kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.=
com&gt;<br>
<b>Subject:</b> Re: [cip-dev] Manually run Kernel and IEC tests on M-COM x8=
6 and generate results</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Hello Sai,<br>
<br>
&gt; From: cip-security@lists.cip-project.org &lt;cip-security@lists.cip-<b=
r>
&gt; project.org&gt; On Behalf Of sai ashrith sathujoda via lists.cip-proje=
ct.org<br>
&gt; Sent: 12 November 2024 04:14<br>
&gt; <br>
&gt; Hello Chris,<br>
&gt; <br>
&gt; Hope you are doing well.<br>
&gt; <br>
&gt; Regarding IEC 62443-4-2 certification, the certification body has aske=
d<br>
&gt; for Kernel and IEC test results on M-COM device. Based on my current<b=
r>
&gt; knowldege, I believe that the test suites mentioned here<br>
&gt; <a href=3D"https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-" =
data-auth=3D"NotApplicable">
https://gitlab.com/cip-project/cip-testing/linux-cip-ci/-</a><br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55 &lt;https://gitlab.c=
om/cip-<br>
&gt; project/cip-testing/linux-cip-ci/-<br>
&gt; /blob/master/submit_tests.sh?ref_type=3Dheads#L55&gt;&nbsp; shall run =
for every<br>
&gt; updated kernel image on different CIP reference hardware in LAVA.<br>
&gt; <br>
&gt; Since availability of M-COM device on CIP LAVA Lab still needs some ti=
me,<br>
&gt; we are manually running each test suite i.e SMC, Smoke, LTP etc. from<=
br>
&gt; <a href=3D"https://github.com/kernelci/test-definitions" data-auth=3D"=
NotApplicable">
https://github.com/kernelci/test-definitions</a><br>
<br>
As Jan said - we now have one in CIP's LAVA.<br>
If you have issues using it please let me know.<br>
<br>
&gt; <br>
&gt; There are no issues with running SMC, Smoke tests but while running LT=
P<br>
&gt; tests it is trying to install some dependency packages to the root fil=
e<br>
&gt; system. Currently it shows it is a network issue but even if it gets<b=
r>
&gt; resolved, the packages cannot be installed because the security image =
has<br>
&gt; read-only root file system.<br>
<br>
So you'd either have to use a writable filesystem or pre-install everything=
 into the original image.<br>
<br>
&gt; <br>
&gt; Another idea which needs to be discussed is, since Kernel tests by nam=
e<br>
&gt; means focusing on testing only the Kernel, we can try to use a differe=
nt<br>
&gt; root file system to run these tests. But this is just an idea, this ne=
eds<br>
&gt; to internally be discussed within SWG and with Certification body.<br>
<br>
There's no harm in using a different rootfs, or in improving the one curren=
tly used for Kernel testing.<br>
Indeed I believe Iwamatsu-san created separate images for LTP testing previ=
ously anyway.<br>
<br>
&gt; <br>
&gt; I request you to provide any suggestions regarding the attached LTP<br=
>
&gt; issues.<br>
<br>
You'd need a working internet connection to solve the specific issues in th=
at log.<br>
<br>
Kind regards, Chris<br>
<br>
&gt; <br>
&gt; Thanks and regards,<br>
&gt; Sai Ashrith (T S I P)<br>
&gt; <br>
</div>
</span></font></div>
</body>
</html>

--_000_OS3PR01MB61037D6982A3F30EA4F12CECC2242OS3PR01MB6103jpnp_--


