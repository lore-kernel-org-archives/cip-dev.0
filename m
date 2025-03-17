Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB86C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 09:01:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.47850.1742202058727926655
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 02:00:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key3.smx header.b=pB2T6hak;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key3.smx;t=1742202034;x=1743411634;bh=mhR24IWS8Lqp9kIQ/VLP68E8Fo18foG1JhEPQgR
	GsN8=;b=pB2T6hak2aqNIqCzHlXrQV6dEUf0x1y+6oQSPXd6fI47vol79mPbG9pYTnx/shtziIpPt
	VVhjTOzSCVUZlwTFxxx+uoMt8aFi9tXMfpLhodwQCf4sKEL+fxMsxaSjhOhkUxbA7I152uOsPk5id
	23XblbJCvuiBbm10Hj41q4nNnV7Re8J+6aWUzBaxq7Ec/lqJwaho+LEHL5tfgpBwn1l4Yv1ZKpNlt
	3lp90PY/8GtEhPoqiq1/aPqdnMWnom/XqVpE7XYgFC9wGduZx+kTD3Z/h+RJH6Pp4uU3yCumHIKMS
	bIEOmmqTUzQ3/3yVEcIfZ6pnq6HxjYcH+8H5eo4s9A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 52H90YFK2213388; Mon, 17 Mar 2025 18:00:34 +0900
X-Iguazu-Qid: 2yAbJ3LJ2u1ygvPfcY
X-Iguazu-QSIG: v=2; s=0; t=1742202034; q=2yAbJ3LJ2u1ygvPfcY; m=b4NCae10GCs+sew5V16yj0xnVqPe+44v56ezRh/Arjs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 52H90XCm493678
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 18:00:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aJ1Eh2ZAoD3wVO7+awAZQ7l1ro8FMjqZnLuPdsFPvOXZgs6lre4Hoh/W4Yx6L/SBljX5YNlRzYvdDOBRpHeizFbX36IQ3f1Cq2npEwU309ikM2z1z8DdKnkEAYhLTdhQy1/J5GKCwc9iTSBOqgA7rzOZgRHckoXkwd/I83u9KA+7wO30RWNuV55Iohn/x30Ceem2xr5iBguSiQJ6kIRWzNJI45toQV3AbTB9wONENj1mB1O+V8qkF8lHRySgCSeFCSCbUH6UAW69+pXXcrTFmlXxU1FDVrmZkWpv2dytoNDJXy53d8WC+q+Rz6T/f6nxVLmm18DGmOIYB9M8nRamtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhR24IWS8Lqp9kIQ/VLP68E8Fo18foG1JhEPQgRGsN8=;
 b=wttkWwj+1UUDGyNOg6YETgaBuEsWBC4GaAKsIu+Tyi+flvlvlmmiiUdQIQINN3Eiycs59UGD5bNA2vV+D28g6I+kh9tH0kmKQ/A3gXjTPthvCTAp81Zzoz9C7nfwrweX6O7HcQK2FhKDaSyK5R1aIt3GuRGefsxmIwrgpYlxWZ2SkY9n7OIGZzOWkOM7qn24e+5LyOuLpkm0a9xuJ26CxAG7yJt/GWh8pd1AQxjE3AJejm2ephZK/ENmTFTjC1mBZhe0KQps/Cx422Wrj8+DCr6zbpgPYjh6Yz0sSzcnJ9AHUDg8O3YDY5xWCLT8riZ5excR/9dYh82+H7MXPwxHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <uli@kernel.org>
Subject: RE: [4.4.y-cip-rt] Actions for fixing repeated unpin_current_cpu()
 WARNING
Thread-Topic: [4.4.y-cip-rt] Actions for fixing repeated unpin_current_cpu()
 WARNING
Thread-Index: AduRdgVHesA6lMyzSIW9gVxlWsy0CAFo/Mpw
Date: Mon, 17 Mar 2025 09:00:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385AB63486AF2E91790E67BE1DF2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: <182B595B8FA1D05C.13955@lists.cip-project.org>
In-Reply-To: <182B595B8FA1D05C.13955@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYCPR01MB8390:EE_
x-ms-office365-filtering-correlation-id: 9060f672-8fee-4396-9436-08dd65322bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|13003099007|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RWF0Vy9GZitaLzZNcW9zbmxyTjg1djRpUktRRmVtL2x2SWo5cmw3aC9T?=
 =?iso-2022-jp?B?S2RpcU5SV05hREd0QnBtcHRLV3pBZ2M1L2Z6SDFVQjJYUWZVZFBkd0I3?=
 =?iso-2022-jp?B?SUJwMTZMSjZPckdWY3NoQi91L3dkOGFHZk1UNGxUTVR5cVJtaXFaRS9W?=
 =?iso-2022-jp?B?OXlBaGprTWtNQVBkSUphV0xOYzZLVDJGU2ZFU293UnoyZWlBMXZVU1pV?=
 =?iso-2022-jp?B?eGVqV2Y1TUVJeXBTQmhMQlVEcGpFQ1BETHBpWEEvcmVFT3F5ZE5JRXkr?=
 =?iso-2022-jp?B?bkFIK0JNVEFaUERPaFIxUEJGTFJ5YU1odDJJUk5qOWZaVXgwcnV4azRj?=
 =?iso-2022-jp?B?MXlTMEFyVEh4R0V1cUhiSDhaUUUySjNxSzdVeFJGY09VQTZIeVZVTXA3?=
 =?iso-2022-jp?B?WkhKS2VPbUkweEg0NHlqTVR5YzVQamhKREhyVlVybktIS25RMEt2MU01?=
 =?iso-2022-jp?B?Yk1ua0RCUlI0aEgvdGE5WGlkL2JIUUs2QmdwZzNDS0h4bDc0MlNYdGxS?=
 =?iso-2022-jp?B?NklDK0xMZWIzcHAxU2tNQWJncnhVaVdnQTBvL2Rkc2VwaTlTNHl1Nnd3?=
 =?iso-2022-jp?B?MFdkVDhDaTNJYnUzckN2amw0R244aWc4Q3ZvSmZvbVpBKzlpdmtqYW5Y?=
 =?iso-2022-jp?B?TEJPN2htaDY2d09vRjErQTJiZzF2VG8yNG9oN21kMFduOCs2QzYwemVJ?=
 =?iso-2022-jp?B?dldzeTZYcnNBUEl1QmcycXpDVmJGalozM3IvaVBlaDBKNHMyLzllRWdQ?=
 =?iso-2022-jp?B?K09PbkRoWEZZT0RxY054ZDc1SjdteW50UUNEeDI0TU9qWUhra3NqRHYz?=
 =?iso-2022-jp?B?aG1FbDI4bnBPTHRHVFM2WXhTZjNzTXJMMTZkcFR3YjhiTk44MjMvWjB0?=
 =?iso-2022-jp?B?WWlhaVRvQzhBKzJ6S2dMSUFPd1hVVzhHMFAyZGZmL0t1L1JjVXFpWTdp?=
 =?iso-2022-jp?B?aVJ6Q3g3bDQ4c281VVdUWGViZnZmZWlwVVZNU29XdUJtOUFSQ3loUlZ2?=
 =?iso-2022-jp?B?elhZVnRuRjJrQ3JyZXk5aUFRaFZwYUl5cmpVSEJmZWthYmZrMHFWOHM5?=
 =?iso-2022-jp?B?WCtUNVdjNGNkNDJLTzhJcUpnbk8xbTcxSWRlMllTSXVWWDVuZzh2TnZt?=
 =?iso-2022-jp?B?eE5aanRJNWFnWVNpUVZWOURjNzlpMlBPNXdiU25nYkRLVVFOQzhTUFdk?=
 =?iso-2022-jp?B?eXd5MjZOcnhDMTU4U01LSzlYMFFzUW5xc1B1QUk5THFrd0FnM1Ewb1Zq?=
 =?iso-2022-jp?B?d2JZMGV0TFE5ZUpXaWZwcFFGWE5odUtVZkF2Q2FqWldKQXhUQzBhTWI2?=
 =?iso-2022-jp?B?OExQbzZXbzRQTWw3ak5xejZ5VlZqVGZZTU5HQjVaNXZUb09acm9sRTBj?=
 =?iso-2022-jp?B?dGdSWE41ZlJyeWtOcHJCekpJWlBzNVp3a0p6ZDJJQ2hKQ1Z4VGszWGxT?=
 =?iso-2022-jp?B?MXh3NjN2MDkwcUNGRmJNMzBiNVowVXA4U05Ca1FyZk1xSWFUbHp6QWFl?=
 =?iso-2022-jp?B?VUNNYWVnb2N1MlU2czF5VEpuVThXekE1dHFGMmFRaHBIWkxnbnFqeWx1?=
 =?iso-2022-jp?B?b1V6MjRKRmRYR0dhWkdpSFhNc0pYWStvbzBoRTc1TWNvRXhVNW11SVpM?=
 =?iso-2022-jp?B?Wk9tNXBOeGptWW1FOW1rMHVkWUlIQm0zZDkwR3hXemtuRGhNSFZyQVE5?=
 =?iso-2022-jp?B?Y2tZY2VWQXo1dWJ5alpoV1NmUFAzT1d3YTBFaGozalgwNnhldDNjMHI1?=
 =?iso-2022-jp?B?Wnk4Y2N2M2gvQXBNd3k0eFpvb3h3aitHT2xRbEdIVEVwZzFIVDU0dkI4?=
 =?iso-2022-jp?B?MjYrdC9Nd01FWE9EN2kvNmNENFBseWtwaHRUS1FrejMzd1o2a0E3b3JZ?=
 =?iso-2022-jp?B?Nmg3TzV5VUttbTlFbVVxblU1dmFCdU9rZCtvYUZPdS9YdnUrNDFrWVVm?=
 =?iso-2022-jp?B?bDVTZkZJS0JLcUxVUXlHR0ZPT085NkdicFk0QTJmNlQxWWFZb2VWN283?=
 =?iso-2022-jp?B?WnE0eFAxSkp0UkQrR1k4Tko1UXdLQVBGZ0VQbElqNzl6akFrRlFSRkZ1?=
 =?iso-2022-jp?B?cUc2T2Q0RTQ0YU15aUc5NDNvWGhNamM9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RWppbFJiNTRSWDZBSzVpVHA3MkFleFNHVWRmNW51cTEzRUI3TVUvc3A0?=
 =?iso-2022-jp?B?ZXFiNUpPZnVjY0VlUTI3d3FJN3A4MWREaTMxUnNKK2Z3Kzg3MjhZVVNT?=
 =?iso-2022-jp?B?cTNPblpFUmNsR2F5ZVQ1cnErVkwxTmdZcnNNTGFRU0dIMHgxZFY5UE80?=
 =?iso-2022-jp?B?VVRBbXViZG9iNGxvL1k4dE9zeHEwSGEzMkRkaU9OanRpUERXdHNTVWov?=
 =?iso-2022-jp?B?T0pPcWFJNE9aZzZPS0luWnB3c3AzNC9oR3V6QUhaQWwrSUxnK1ZTNk84?=
 =?iso-2022-jp?B?dVA0V29sM3NaMTdXdjNGS3dJUHdaam83aXZiNkFoMTJFajRvMUxSVmVu?=
 =?iso-2022-jp?B?UlgwWm9FUVE3RXRYSDk5R09UYTNHTkZUZnQwbGhaaFYvK3N0MzQxSnFF?=
 =?iso-2022-jp?B?Yk5WSDRDN1VNSURXeWlERzF4VHJsQ3RrUWtFY1BsR0F3VTZwNWNtS1dT?=
 =?iso-2022-jp?B?dUcvQ0E2R3VIZWdmK2dTTUFneEU0dVExTnhET3Z2VzJHOTRMT1FDbmdr?=
 =?iso-2022-jp?B?MWVVY2hmdVh2RCtRdjZUNmpiYlBrRlRvSHRKaU5FUDJaellUMG1sU2tC?=
 =?iso-2022-jp?B?ck9WWnJCNHZsQkhCUFlCUnF1YnFmQUFOeHZRRmlCR2VpbWxGbWc0SlhY?=
 =?iso-2022-jp?B?T2Q0eUIzTDk5SFNpdHl5R2dlWEVoU1lSb2NQZ3ZZeFpYekVKV1d6L2tS?=
 =?iso-2022-jp?B?V09RbVQ5V2RhR1JYcnM3NCsrQnAxNnJWV0RDY3NjL0JLQmU2b09wRUo3?=
 =?iso-2022-jp?B?TUczSjFERDRNWlo3L0xoRXQ3QTdLdHdCMUJVWElnUlhLekxheVpjSDlP?=
 =?iso-2022-jp?B?S2Z1aFo0clFwUnVjTTVWbHVDdFBNUXR5NXk3cWRRblNYS1VqVGd0S25p?=
 =?iso-2022-jp?B?TE1EaVovdzU5Z21PVHAzOUNncUZld0RCbGtiTGhWZzZEWVZOOW56cFVK?=
 =?iso-2022-jp?B?M0hWa1pRRFF5TXlTWWFoQVlURGJWOFhLOUdRUzlidkNzSkhvUkxabnBa?=
 =?iso-2022-jp?B?ZUFBMmJDK1c0TUcwcWlGZ05tUW1RVEcwQ3pmUlhtWjd6UmpEYk1jQUg2?=
 =?iso-2022-jp?B?TGUvd1VtU29xcWVGY1h2enhJRlhBaERnRXdNeWp1dGpnQ0pZNTE2QlhR?=
 =?iso-2022-jp?B?NW9RaHMvTFl4S1ZKRUViaEJ0RmtFWDhDQWdYMS9XSEpzdmJ3VklGVmdn?=
 =?iso-2022-jp?B?OXpQNEF2dEpNdVRuYXJDdzhHbUhFcVJBS2RRa1h2SzFPa0RVUVZvSFpq?=
 =?iso-2022-jp?B?SGx3aFNrTDlFdVUrUzl2bjBOc3ZLRWEreUR0NGRxZUxDT0VHeXQzaDFx?=
 =?iso-2022-jp?B?d3BuSUU4WW9RREUzZnhYaVNrRUl0TitLVFpOVVRtUXk0R2g0QVlPYXVE?=
 =?iso-2022-jp?B?TWhjck1rU3NrSStSemJUMVVPbmQxa1AybzJDek5BQVpiUy9nZDdEamEw?=
 =?iso-2022-jp?B?NEJQV0l0MFVENjJKZmNvQVcxSWh4OElUeUVhaE1WclJ3ZUxCUTh4UHZn?=
 =?iso-2022-jp?B?ZjN3cmhBTGN1YlIveXhjR3kxTDczSWcxY3dPZVRxY1gwc3ZzenRLRWFW?=
 =?iso-2022-jp?B?NFBtdy9hckdhZTZ5OWcwTWFKWkN6Mm1DYmZna2lvU1BnQmRKbU1ES3FI?=
 =?iso-2022-jp?B?d24vTm9XOVJYWDBmOGMrTVhUWnIrWWk2ekZwQ1E2aTVCOW8xQ3NOajFN?=
 =?iso-2022-jp?B?TFl5aEcxV0JiUHg3bnczTE92ODBoWXQ4R0ZraDRoWCtoUFhnU3BEUWYw?=
 =?iso-2022-jp?B?L1BUZ3pIK2dycTJKR1BTa1RWbythYklPb0NvZktKVitTbnRVNkNnZVo4?=
 =?iso-2022-jp?B?NzdaM2RnOGIwbENSQVVrdEdIdGx4bEgwZ3dDM00xUHVxMTJ1TUdUTWNs?=
 =?iso-2022-jp?B?aHV1K0NVQUVZZHpObnNRMWQ4U3BjdE5hWVBLQU9sUW1IaCtOc0twdHlI?=
 =?iso-2022-jp?B?aGkxSk5NWFdLYjdWZmFTTVFYalpzb1VnZy9FL2ZTMjJRKzhXT0JVNXJQ?=
 =?iso-2022-jp?B?Q3VYU1pZa2JoWFFSNmsrdGFtL1FScE1KQURwZnZ1SFd2RUd6eStjVmhK?=
 =?iso-2022-jp?B?K2ZFU0d5MjhFR1A3RUdGbk1kLzJKRXRmWGNab0hqSzFWaDA1WHR0Zll2?=
 =?iso-2022-jp?B?cVdweFlwOGR4ekhxeVE1VGczQWV3OUlvUko2MGFMcCthN2tBdHdQZlky?=
 =?iso-2022-jp?B?RVJ6cVFvOG1nemZLSm5YTjVWWUorM0hiWlp6cGNtUlRpVWVuZVQwbUJQ?=
 =?iso-2022-jp?B?TUIxQjNseXI4WVZROC8wQXNkYVJmMXp0dVNYRWJsaHUzdVJNTE1scWd0?=
 =?iso-2022-jp?B?VG1iemhwdTZZQ1h4ZzkzKy9ObGxrM3I4OGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9060f672-8fee-4396-9436-08dd65322bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 09:00:31.2471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EZc0Ah3s13VciveypJczMnne+Na/fdUcMCTU2Qa+ReYenuUOpu4UvMhmU+lRmjputppEsmuh8Dw0MeB11fAhYyIqzFQ5oAPXUpBW4D3TJohShKOTZUjapBSBNIB2h5Ws
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8390
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 09:01:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18222

Hello Pavel,

Sorry to bother you, but I'd like to know your plan about how to apply the =
patches[2].
(i.e. about the following questions)

> Do we need to apply the patch to introduce "system_scheduling"[4] to 4.4.=
y-cip (non RT) first?
> [...]
> Should it be applied to 4.4.y-cip-rt only?

It seems the next 4.4.y-cip & -rt release is planned in April.
It's great if the patches can be included in the next release.

Best regards,
Kazu

> Hello Ulrich, Pavel,
>=20
> Pavel and I have been discussing how we can fix the issue [1] that
> unpin_current_cpu() WARNING occurs repeatedly while kernel booting.
> This issue happens with 4.4.y-cip-rt (In RT kernel, v4.9-rt or older)
> and not with 4.19.y-cip-rt or newer.
>=20
> I created two patch series[2][3] (two different solutions for resolving [=
1]),
> then they were shared in linux-rt-devel lists for review.
> The both were acknowledged "as OK" there.
> Pavel selected the shorter patch series[2] and we want to apply it to 4.4=
 CIP tree.
>=20
> Here are requests from my side:
>=20
> To Ulrich,
> Could you review the patch series [2] ?
> Details of the issue and how each patch is made and work are written in c=
ommit messages.
> The WARNING has not occurred in 20,000 reboots in both cases[2][3].
> Feel free to ask questions, request to improve patches, etc.
>=20
> To Pavel,
> Do we need to apply the patch to introduce "system_scheduling"[4] to 4.4.=
y-cip (non RT) first?
> Its original implementation (i.e. SYSTEM_SCHEDULING introduction) happene=
d in the mainline,
> but our custom patch[4] does not make any sense for 4.4.y-cip.
> Should it be applied to 4.4.y-cip-rt only?
> The second patch to fix the issue[5] must be applied to 4.4.y-cip-rt only
> because the original change was made in v4.14-rt branch and not in mainli=
ne.
>=20
> [1] https://lists.cip-project.org/g/cip-dev/topic/108515524
> [2] https://lore.kernel.org/linux-rt-devel/1738629964-11977-1-git-send-em=
ail-kazuhiro3.hayashi@toshiba.co.jp/T/
> [3] https://lore.kernel.org/linux-rt-devel/1739170545-25011-1-git-send-em=
ail-kazuhiro3.hayashi@toshiba.co.jp/T/
> [4] https://lore.kernel.org/linux-rt-devel/1738629964-11977-2-git-send-em=
ail-kazuhiro3.hayashi@toshiba.co.jp/
> [5] https://lore.kernel.org/linux-rt-devel/1738629964-11977-3-git-send-em=
ail-kazuhiro3.hayashi@toshiba.co.jp/
>=20
> Best regards,
> Kazu



