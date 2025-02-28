Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C3C19776
	for <webhook@archiver.kernel.org>; Fri, 28 Feb 2025 12:56:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.14667.1740747414380284306
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Feb 2025 04:56:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=dfr2Mn4U;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1740747412;x=1741957012;bh=WaSpdbjVEtweNpqDh3XfpYPEfnIbtg7DQwjDjrm
	u75U=;b=dfr2Mn4UYYdM5QKSh3vYVler5CzPtRK07yR5dxKAckUd4r3Hu/i40Gcb1NVLxgUUrOJwG
	hcxK8TgjK7HEzPrFFLS5j0mBl4oFavD2Ml0ZZFXRU0mDgV7g5yuFD9xwPtPUdfghjeIMJ/br579qp
	Rp49ry1WiCOGFqw1r+uDcE/6G7/fJxw6FPAIR+eTXr60T0sJ3eR+HzZZzsqQgZircr2+zs6buu3CM
	ztlShfu2OXEEnOJ3324o6EDFR9nf2wlIazo8PFOjBJDFYUkB0p3qowOHugdjvxAPE/DG+ip/VrjAJ
	BMtGvuATAOmWVP8W8rnO76VsWfII2jJ3mkIZAwOFbA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 51SCuqbA392597; Fri, 28 Feb 2025 21:56:52 +0900
X-Iguazu-Qid: 2rWhyCKR5ExjLIEB4C
X-Iguazu-QSIG: v=2; s=0; t=1740747412; q=2rWhyCKR5ExjLIEB4C; m=kD2n0JEoQEkYEZfvJs8bIPjqAto77qMYhg8R9ozSsH0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 51SCupYY3982033
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:56:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5tSOD1wNwlYpXkHHBxlrhIULNwRhFkO5uaZ3xVOqIvb62vxGGEd1T0xCL85+L6SrZ5pysVE/eE27pF2NO6Rmr950aYdEmAFFDMEaKuyIkReswc7BWjGV/WF4/wpD2smMCJfRIn3LQhc1FLuKtlfLOiTfW4/czPTcDp0rt1RliyJULpFmZvi+ecpJwQPE9khxw4ndqN4VlvjstNW88uO4QIVjHKM7caOebN2BCaVCiAA1KJ+aDNmkQlOA87I2a02O2dZ/IiAX+2Cz04s6/YUxoLw0RiSQRU02KGYzX8XMxhjG13WkmJSOEfOvlDX1/sYBEh5KCgmOVidYAM6CVy0Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue03kzgOH2KY2KunozStrZOE1dxIBXIrJ+n9y1OnGjY=;
 b=kJ3WjCOR0fwlJKZ9ZmsJYd6+FAk7TnKcqjmJY6Mfc5ciodidhrwbr4zWa7rA8fRtY/pv46MoqL2AKwUVrGGTidabLqx2BzEiHnbxvJ7ZskT5EScz2TZ7k8QKuUGhXseJ4BA15YN7qiXLRDMv8SYAkNIApl1EH8muXlH4ESgc6bsaNCUHK/k2MSjMdtIpsZu8aDctAbZSDTYr/4XtAq9urL9DNPo2sIBY5Z2kVWOXAEm4QQVW4xLeQ1MyNudSJbzUsX8qmtQCXhV5q1wM41ODZtado18PBpwnurkCGqiFlJw+0fSoRaO4C+WhUqqoY+4ccVwA0M7gEC7Jc/Y2gWOqVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Chris.Paterson2@renesas.com>
CC: <jan.kiszka@siemens.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <dinesh.kumar@toshiba-tsip.com>
Subject: RE: Updating root file system used for kernel testing
Thread-Topic: Updating root file system used for kernel testing
Thread-Index: AQHbiAY0k37sypfPYkK+BZ6qIlAP7bNcrpRw
Date: Fri, 28 Feb 2025 12:56:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818C4E6A1A2A38D174182D892CC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <OSCPR01MB1483816E3365201CB54911E2FC2C22@OSCPR01MB14838.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSCPR01MB1483816E3365201CB54911E2FC2C22@OSCPR01MB14838.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB12163:EE_
x-ms-office365-filtering-correlation-id: c45d84b6-c10f-4ba9-a578-08dd57f75d8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|7053199007|13003099007|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?eVd4RmxFV1VGZzBESHh4ZU1tS29oZEk0SjFOa2lYejZPVnYydWlPcnpJ?=
 =?iso-2022-jp?B?NE40dEhwSkhvNWFTQVh3Yk8xcURMRTV1cnAzMXJoU1lJSXVjc1VoMGRh?=
 =?iso-2022-jp?B?SWVndVFtOVNIN0trUnVrZ2UxYjk4MncwZ2M0aWZRWTVsT2d0Yy9aaTg3?=
 =?iso-2022-jp?B?TXpSaS9FempwckpwNm0xNFhKNzRaYjNYS1p1c2xlcCtDY0pkcWNJcUVu?=
 =?iso-2022-jp?B?NEl1YTV6YjZMSDZJcmp6ZDBmSnhmYTkreVpvZ2ZSRGt3YkVyWHpidkI2?=
 =?iso-2022-jp?B?UjdFbW9lZ25ZdkJRUjNQTytUZDdWRWF2eTR6RnhXZzc3bHJnMmdXenNJ?=
 =?iso-2022-jp?B?UDhOWE03OUo4TXcvZ3BBNTBvL2V3NGFJMENOTE96TENRWlJZKzhZaEpm?=
 =?iso-2022-jp?B?bndsWGVuM0VpNzUwQXRYMElaUDRRV2Z1S1lBdXJZMUV6QXBGRFRNMjZL?=
 =?iso-2022-jp?B?VElOdlpZWFZ3UFk5eUdMZEt1R0JJY0VlaHRqL2ZoYWtOb0dqdnJoRno3?=
 =?iso-2022-jp?B?a2xWVWp1OGpTQmFodjVBQ2c0b1BGRURwNDZxWXBYcjVyWGJGeXFjaFd4?=
 =?iso-2022-jp?B?VzhJenR2cG44OWVhMCtOVXNqUlNGVHRCWG9DMzlGaS9pWHJ2a000alFs?=
 =?iso-2022-jp?B?S0xpazh4SzNDZURUYnlTbVB0dEVGeUJFL0FJMmNuRG55QWNreXhaQ2Q5?=
 =?iso-2022-jp?B?bjNzNW05VUxMRE1id1NHbWxFeVpLeUdCOUVKRlZ3ZTVhcVZJdFVCb2Yr?=
 =?iso-2022-jp?B?Q2ROS2NzUjVtOU5wdEZwM2tVQ0x5ck8raC9GVXQzYjJXQ3J4T0RwRTV6?=
 =?iso-2022-jp?B?cnI2WFVON2NKTU16dWJZcTRZdFVBYnd0dHkvRU55bDVGRFU4TXBRWDJR?=
 =?iso-2022-jp?B?dlJMNHpVN2VTZEhPWmYrWVFqL3NUb2xWTnVDZXVRM1Q4MGZEZm0yMTJi?=
 =?iso-2022-jp?B?TkdrOENhRFB3U1lQeU1pVWR1SkdrNmpRWGdyZHFPZXVwcC8xMlNVK2RE?=
 =?iso-2022-jp?B?cjQxREJNeGhBZGI4d2ZwbTJVNTREemRmeGUxYWNIUUFVM2UyRVEzcU02?=
 =?iso-2022-jp?B?SzhvSS9zT2FYQnlyS2dhaVpiOW9hTnZ4c0cvQjV3ZjNxSTR2MHVIdm1R?=
 =?iso-2022-jp?B?cDZ3dExrYUZRVUxpZDlQSnNaUXNTMVgyTDlmRlU2M2VWQXR2ZGszMW9M?=
 =?iso-2022-jp?B?UjhqRmI0Qi9zL29jYjBpOEp6Qk1ZV3hYL2R5bUp2UEYvcGVWT2orVmY5?=
 =?iso-2022-jp?B?ZHcvTmptdGErNlczTkZyNFJZSDhxNHNYUTQvMFBONDhQbk9ZYWprb3hG?=
 =?iso-2022-jp?B?cnVxc2pPV1NsanBOUWFTS29ubnkrOGlOakNzdk93a2ZWUjkya2daZ3hN?=
 =?iso-2022-jp?B?QmV0T25aTCtuM0I5b293cXIrRVEzR0lvc2pwcHFGc0lSWnBNTWJtdFN6?=
 =?iso-2022-jp?B?aWxNV0RPWCswZExUM1ZlRnJwZmlBTm1CUXlMb0NvUEFXZjRVVi9mVVEv?=
 =?iso-2022-jp?B?QUZHZ2NKTjJFeEZzaVNCT1VKUWx5UWxJdEtQVmp6eFFkbnJuQTkwcDhB?=
 =?iso-2022-jp?B?MXAvOTlENzYzVW1ZMkxaQ3l2a1I0UGJGNkRDbGRTL0dlSnZWWTVrL1V0?=
 =?iso-2022-jp?B?bDcvMmIvM3lBaXlMalZadlp0alhoamhrdmlHcjA1Yy9FWGZUcmdOZjdH?=
 =?iso-2022-jp?B?MUlFWnhPSXVrak9DWDFSRlBSMjJCc0RzNktuSThBeGw5WkZseVJCemhy?=
 =?iso-2022-jp?B?M2hYMGJ3dVZLUENEN3M4SFNuSDl1SlA3TTJaUW9TdGs2d0hWQ2hQZWNs?=
 =?iso-2022-jp?B?ZGFMaGhyWDF2a21BT1NDSjdpL2k2MGlBa1ZvelA0ZkZ1L08xcDh0d3Ur?=
 =?iso-2022-jp?B?eUFXTU1HeXVBUTYraTF6ZkJKb3J4QzJSZnNlSHg2TzA0ellGK2NpQ2Vn?=
 =?iso-2022-jp?B?cHM1cmpoc3Z0VlJLSjFKYWFWbDVMNytvbzJwRnFCckd0Q013WkhVdEIy?=
 =?iso-2022-jp?B?Y3dma2ZWcGkraVh6aEUwQUdrMklHNWhZVVlsMnFHRlZFVnFFUGx6SlRP?=
 =?iso-2022-jp?B?WGRyUmQzNUZkWkozZjFpTU5hU0Y3MjQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(7053199007)(13003099007)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UFIwVzVDZVFGbDBvamUzZ1Z6YUJCekNIWVp0bVkvRHlzdlRPVUtuc2Jk?=
 =?iso-2022-jp?B?ZEppWEE4MnZ1NUZINCtTL2QyallpNTRSY0M2cDRwa1ZMWTJpWDAyZ2dP?=
 =?iso-2022-jp?B?MHdUTlVQS0RVNjRkSWtqUVlpVnpaWEo0bU9CQW1JMzRlZWRQZm83MFBk?=
 =?iso-2022-jp?B?VVF3RitBWFlhL3kwRW9aTkEvQWFjVWlXbVF3RmtlSXlvY3ErZHNLV2pE?=
 =?iso-2022-jp?B?WjBRYld4RjFrMm9wdkJnaGZqb1hwRGZSSnhVVHRack53dThmWXpUaTlW?=
 =?iso-2022-jp?B?aG5Fc2pCM2lTUXFPUnJ0eWk5QXMyUEtpVEk3YjRHWW4zLzA4SnFzVGk4?=
 =?iso-2022-jp?B?dzBwVkp0VVk2b3l4Yy9PQ3g4QlZUNnZ1cEZEc2tmbXdWZHMxRldFTkM1?=
 =?iso-2022-jp?B?SFloRWUzT2dqbkFVcTNmQmJ5N2c4dFVHTndaMllTeG9vd3o2c05XSHMz?=
 =?iso-2022-jp?B?bU9oZUppMVpWQm8yUzRqSVBVM1pUazZFc0ZwTEd4Y2VpYjdoeEYycnFC?=
 =?iso-2022-jp?B?L0lxeEU4SmJCckU5cEpqSml4b1BoSzFsT0Q2bUo4RWxjeWc2THZTVXNz?=
 =?iso-2022-jp?B?UTEyRTJuUlV4YldmQUg0Q1FMWmFvblVpN1NCU2p6L00rbDZXMGJRR25j?=
 =?iso-2022-jp?B?b1RCL29UQ1hXOHg1Y2ZPTDh5L3dBWGZBWEU5aEtXMkVkTzdySnNocDY1?=
 =?iso-2022-jp?B?OWVFcjkybGZjdGlEZmlCM2Z3MlFIYjczWEVWaXQyeXRPRGJQWUlMckk0?=
 =?iso-2022-jp?B?TzZHQlR6Sk16aUtxakg3c0g1ejZCQ0UvM2FOdEcrcHNJU2d0azBLRDNX?=
 =?iso-2022-jp?B?cVlWSTgzRk5MRGp2MkpNS1dMemh6NG9pajhBOG9hTjQrL3RGOHhCWFJB?=
 =?iso-2022-jp?B?YXR5NGZ2eEI2SlZzTmthTVArVVZ1eVpTTVpvYnBlSGRhT1FUY2NqUjNl?=
 =?iso-2022-jp?B?a2NYL0VJbzIrMytmVjQva3l2M2psUEczbGFnWHloQnIrS2RCbGpOQUhh?=
 =?iso-2022-jp?B?M0NHNkdmTzlkRWxOMXc1ZjJlWEZvbDhYb0x0QjlSSFpUbVEvUkU1MXVl?=
 =?iso-2022-jp?B?aDYvS3VlZHlRZ1M1ek9NME5KM0NzRERtYmpQVFZVS3dpRDAwWDVDaVpB?=
 =?iso-2022-jp?B?REVWcDJTVFowSS9lZmtJTjgxcDdtRVRTRU0rUDNLSnRYWEJoWi91c1oy?=
 =?iso-2022-jp?B?a1ZYYlFNMzBqT1EvTWx4SEI3SDFzMVlLNXRHcURhWlRVMFY2VEl2MDk1?=
 =?iso-2022-jp?B?MHozM1RhaFNaOUczemdHVXlINmw4YzdsQW5zM2lzNEpNWk82ZzMwWENH?=
 =?iso-2022-jp?B?aDhIT2xPL3VMbU0xU2pXOHRkcEpxM3FWS3RrYW1aQkpBNHM1ckttRVI2?=
 =?iso-2022-jp?B?SERLL1BQejlRZ1dqdlp4cnphc2dRTnFoTS9OUThaL2JjR3BObjl3Ungv?=
 =?iso-2022-jp?B?emFQTEROTlZaT3A5NVFzYXdLTGpPSTVEVWpyVk9tQm5YRGhDOStQdDR2?=
 =?iso-2022-jp?B?cnRkTld6Q2lwandKZTcwMUZ0blhZYkVheHpNZUlpZzYvWENCbXpWbGFq?=
 =?iso-2022-jp?B?TzgvU1ZsVURiYjJ1YkFpUU5Wb2lxQlQvSGlveXkzd1pNUUlZcTBKSkZX?=
 =?iso-2022-jp?B?SzV5Um1LTEJYRTgxRTRTNm5hdytIcE5heENUbE1TcS9XTWZpYWNMZW5X?=
 =?iso-2022-jp?B?RXBUZ2cwaXQ2YVZ4czF5Yks2REFXa2dVT21IWjNSalZwTFNCVFp6Wmh3?=
 =?iso-2022-jp?B?cUFJSlpvNkltYk9FaTZNK1UyMzdsNG5mcFg4aC9Qakw4RTlPTGRHVGFO?=
 =?iso-2022-jp?B?ay9vRjlpdDI3Nkxtc0xYMU15bmw2WEFuSUM2OEU3MFJJc0ZBdS9ZUktL?=
 =?iso-2022-jp?B?TlJEdDVBY2gyRnhrSUtrMHdUQnI2cGhnVmp1ajY1OW9aUWRab3haZmRx?=
 =?iso-2022-jp?B?REk3amludHhvSUFFeHR4cTNKejhpVHZQRUJvWERNMTVicGI3bktKRFha?=
 =?iso-2022-jp?B?VGJXZnZlTkNoc2VQaUJuZEUxbkZZS3hHcExlbFZNUXpBSmx1VEFvQ3RV?=
 =?iso-2022-jp?B?U3h0SXFxaENoVS9FM3NURDQzRWJEbXhUcHlIM0QydzRKeEdNeHIvVWtn?=
 =?iso-2022-jp?B?MVR4UVRheDlLRTNPSEtzU1dIeEFJcFo2K3QxVU96bDFlZmNqQ0ZiMFpW?=
 =?iso-2022-jp?B?Y3pjb2Q0SENQeGZSaDBmR0w0YjFyczV5UGVBMWo5N3BBcTNnV3g5VHdS?=
 =?iso-2022-jp?B?dkt0Wm41SnBESEtNZ01lQzVnMTBTNmVScHZ6SitBUGRTd0lPL3NYaUIx?=
 =?iso-2022-jp?B?TCs4MkhNemk4bHY2VCtGVzRiNkV0TFVJSFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45d84b6-c10f-4ba9-a578-08dd57f75d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 12:56:49.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ks1CMMlbQrabwWXmCg6/ZDCHRBWAxQwAxmxj2vESdga5cicTPPetixYV5Qgnzntc1OPGA24/S1t1xL3NUB5TA6w4++HDhmrVpfOCyTeminEgoLYB9wlTrhIvAcO38ekF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12163
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Feb 2025 12:56:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17986

Hi Sai,

> Do you have any plan to keep these rootfs tarballs updated with the lates=
t
> version of LTP through CI ? If not immediately then we want to make chang=
es
> so TWG always uses latest rootfs tarballs for kernel testing.

We had talk about this at the kernel team meeting. I'll take care of it.
As Kaz wrote in another email, I am looking into how to make the cip-core i=
mage available
for kernel testing. I am also working on doing this.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of sai.sathujoda@toshiba-tsip.com
> Sent: Wednesday, February 26, 2025 1:28 PM
> To: Chris.Paterson2@renesas.com
> Cc: jan.kiszka@siemens.com; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =
=1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M=1B(B
> =1B$B#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>; dinesh kumar(=
=1B$B#T#S#I#P=1B(B
> DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>;
> cip-dev@lists.cip-project.org
> Subject: [cip-dev] Updating root file system used for kernel testing
>=20
> Hi Chris,
>=20
> Hope you are doing good.
>=20
> We noticed that the LTP version being used in the following rootfs tarbal=
ls used
> for kernel testing are not recent ones.
>=20
>=20
> 1.
> 	https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-
> arm64.ext4.xz
> 2.
> 	https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/cip-core-image-cip-core-bullseye-qemu-
> arm.ext4.xz
> 3.
> 	https://s3-eu-central-1.amazonaws.com/download2.cip-project.org/
> cip-testing/lava-healthchecks/rfs/core-image-minimal-qemux86-64.ext4.xz
>=20
>=20
> Do you have any plan to keep these rootfs tarballs updated with the lates=
t
> version of LTP through CI ? If not immediately then we want to make chang=
es
> so TWG always uses latest rootfs tarballs for kernel testing.
>=20
> Thanks and regards,
> Sai Ashrith



