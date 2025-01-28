Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA52C0218A
	for <webhook@archiver.kernel.org>; Tue, 28 Jan 2025 23:18:12 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.1027.1738106283087288563
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jan 2025 15:18:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=NZb8BpPe;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1738106270;x=1739315870;bh=pzb4mbSLEuGGX6vTiPviFkw8UvFgXjTwjbW55FD
	HI8g=;b=NZb8BpPeyKbA/HwHm83wWmI8KIH2Ueown+gAlKjfLhK7RSwAayhi6jzYiDt5Jjf+K8j8f
	+j33yOqx+b1uotYFFOFhADQVtXq5g1H5Yy+nZesl4ZuUINp3szFkNrRc26zmy/J3/u6z1t5UfbTki
	aRr0K7yshdG9wVeWa82wCEVlILGHK1K1C8kfsstrU3kHB+OlbHms8bnDC2Id7t1noiU/RY8HO23iZ
	DD4oi+KIhNzxAXreSPDt41VURK3K7p2nR1xPj68NjGxgO2H1HNzbu7Xoaw0gXDO15Gm4qIpqDxNYa
	OEmVShLgaAiWyDJiN2Qf2yrfAd5gGgdUu9FcECdmrg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 50SNHn1G251784; Wed, 29 Jan 2025 08:17:49 +0900
X-Iguazu-Qid: 2rWhEqwpiSsj9wKcDc
X-Iguazu-QSIG: v=2; s=0; t=1738106269; q=2rWhEqwpiSsj9wKcDc; m=A4SfkcefVyIwsixrQ9mTksNJA5N5YDJ8YpQV/k1VLhg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1123) id 50SNHm5w1924278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 08:17:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o7eG8olg92T5/QU0FK3J6JqB/JSwnhKprw8fnHwfYoAq+Gf4jqrc3ZO7vJU311TiyDJKhTCY8jbIWPxJoC/yqGpG8o4fQRB1y82E6FdTIixUCPThpzahp+wKJ3mPQJDh/9DLcfZtKdLUWQJUME2ipFGNMwOhSLm3hPehDjG83LvhG4L7fU0DPtlRGAB/Pv1aPFy9Fs/7PSXpHBTTukl6KWI1DpmpSJKFw1VomxkvBCANGsmDTMF+JU4r7KmcxRLEOcdfuEM8ESatuL33sUECFfnLzG7jxUELdvKh6aaAL1uX6a22I323eh/yWGM4G+5NLLh2Mdnzafc1USJtyjKIZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmjRZB0GneRQY3r0VOwz+hYrRkIJYimW6TmP1kPY/O4=;
 b=tR8YOB7a3A/urWilEuisvOOYh1DRntI/A3LzemxGUsfECQt3V9sZva8Ez+ObhnlpdpYSUOol0D7mU/3ByFeqqbTyWcBH9125/8RtecXkDghLkQBoSxDITy+DktOVE+r/Xp/z9BBwalP63xe+7Cl7KJx21CEn3s68EfKgqFT2Djl50/gWSsPnZbxBDZSE3yWT2w9KnzenVk/z/ilCt+D5uLjW07XSREEY3RN+bC16JS9D4mL6Y6B4Kx1TjKzcX3xkTD04jcSj7wuEvVpDHH9DG6niyEP+1ZlBLY+GPdteVBVNLfmTuEEuVufqwCtNDJMvMb64VgXLgIudlRWyQtTvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 6.1.127-rt48, corresponding -cip.
Thread-Topic: 6.1.127-rt48, corresponding -cip.
Thread-Index: AQHbcc0U2eQV0xXR6EWNOXVtDYNFZLMs0UZA
Date: Tue, 28 Jan 2025 23:17:46 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388DE11728DB4806498406B92EF2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <Z5lOaPm5I/7AFDZU@duo.ucw.cz>
In-Reply-To: <Z5lOaPm5I/7AFDZU@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB8417:EE_
x-ms-office365-filtering-correlation-id: b506d75f-ea70-4220-1825-08dd3ff1f9ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?VHhQU3htVGhweG9NYmtLSU12WTFFUExYcThYMzhOc3dRVEh1Y0laclJ6?=
 =?iso-2022-jp?B?N3h5dFY3akptSEd6TlpaNjhsc2xuTktPbHVSckpDTkRPajM0ZHNlUVBD?=
 =?iso-2022-jp?B?UDVOZjRCai9xQ0pIREc3QU1Wa0ozbGFxWTh3YXJXa25vcEMyYkhpVW5n?=
 =?iso-2022-jp?B?RTNJRDRZSlNSQ21NMDhTK2VJZjV0MlpiSWRmNllBMUNnMHJKdEd1Z0Nr?=
 =?iso-2022-jp?B?aEVQUXRRaXpUbkRWN2E4STVqNHVUelJrYUl0ZHJmRnkrdGpWVnBCd0pO?=
 =?iso-2022-jp?B?OCtVSmlVTGxvM2liSk5DdnMwYjh6UDg1T3lVN0xGU1Q3dVl5eEFnNC8r?=
 =?iso-2022-jp?B?UG1xencyWUlhN3BFSDUvZTdkVGk0SFRFYVNHQWJIUE9zZWVDbUVlYXZa?=
 =?iso-2022-jp?B?dFNvbjA4UVk2VlIvRE43aWVuREVUN3cxbGM1YjhhR1VnVXk1SlN3cGdh?=
 =?iso-2022-jp?B?U1VxZW5aVHVDOHg5ZVVxL2NGK0tmbnVlSndLa1dZZm9VVm45WFR6SnE2?=
 =?iso-2022-jp?B?QmdHb05lamNhaEV1cVBWKzI3cmREbVFqbFNqSnBrOUxRc1hFSjh5akdw?=
 =?iso-2022-jp?B?cU8wUHgvVUJ1SjZpWWVZKzRMdGt4UGJRNkk2ZTNqRHpNRGpBWll0d2k4?=
 =?iso-2022-jp?B?TWx5VEZJSWpNd01ST0p4eW4vMkNhM2VtbE15b0JmN2ZGZDlPNmNYdk81?=
 =?iso-2022-jp?B?ZWgvQmRhVWVrekpqbE9TKzRycjBwNTExYVhVdEdJdkdscUEzL2U5RmZN?=
 =?iso-2022-jp?B?TWpCRFAzQzRYSnhmbERvanJVcC9BOWNCSVBNV0ttTk05M0NJMWtoNnRq?=
 =?iso-2022-jp?B?b3oyL01wd1k2SDE3emluRzNNR2lGdk4reEhnNDdRcS9nSU54TjBLTXho?=
 =?iso-2022-jp?B?ZkJmLy9rNFRhRVVzbXpxaXBoVG5YcXZhRWxxYXR5UTRrbkdIUzlpaVhI?=
 =?iso-2022-jp?B?Y1FDUGlaQVJCZi9kd01RNE9tWFFJc2FlNFVxSVJ0NkVVTFRCSDNIRTRa?=
 =?iso-2022-jp?B?K0xnZDdpNXVXT0czcEtKTkQ2M0hKano4NEFjaWEzRG1wSzBWUkxIV1Rl?=
 =?iso-2022-jp?B?U3NpbEV5emUrTFJNUVZqcVhUUmZlamIrT0dKaUFYVDRnSDJsTU1pOUZY?=
 =?iso-2022-jp?B?WDRLZEMrMlBTT2VKWVlkeWF6VmdKcU5YYno4Szdnc3JNQTNzRjA0YkZs?=
 =?iso-2022-jp?B?MEdpVlVuMTBBZEpMbzhXaW1mb2JVdEJUTU8xaGdIbnFGOFppZU1XSlI3?=
 =?iso-2022-jp?B?d2lteFV5VGhVbTlWenZ0dmR3dzlkUHFYbzNab2tDbUV6bVlmaS91RE9T?=
 =?iso-2022-jp?B?T3Y0SmEzRmljb2lpNnpLbUd4Vm84ZDkrVjd3bkttQyt3c05zU2I1cEIr?=
 =?iso-2022-jp?B?V2lRbmVvT2twUWtWVjBNaFo3YUowM1RkQlBGSkJKVEhqdU1iZDJVZXFu?=
 =?iso-2022-jp?B?UCtydnVaR3Y0OHZvM2Y3TDVjS1Fad0N0NUg4ZTdlSnpUSEhrRUp5ejRa?=
 =?iso-2022-jp?B?Z3pwQkhPOG53U3FOQUI1WFp0aXhYK2xSYjJIc2lUM0xTTm5KOVJ5UVVF?=
 =?iso-2022-jp?B?bTdVMWRqMXAzSy90ZDZWeHpCWWNtc200YXhwN01meVdvZllIbWtoUWlT?=
 =?iso-2022-jp?B?NFpPbnRhVFR5dUpvTmUwSTlRNkJLenhOUkxYLzRwcU53WG1HZEFKQTJy?=
 =?iso-2022-jp?B?elZ0TVF1WExldU9hUVNESUNOaTA4a2JHaHBQSkRzdzhSblBuejJwVldD?=
 =?iso-2022-jp?B?SFg0TEVCSkxtWGZJQjVNNFFsTktnQkZ5c25KVjdFaHJsbUVKMUNjVFdT?=
 =?iso-2022-jp?B?THZsbG40b1RpKzV0eXVKWFVUNlhidzBEMzFMVkI5cFJ6d0YvS3kvVzlW?=
 =?iso-2022-jp?B?SUdzdDl3MituN2FpWVlJQ3l3eXV0L1FTRUdoT0ptOXl0Z2VXTm5ZWXE0?=
 =?iso-2022-jp?B?eERBai8rMS82ZnN0RDY2bnRtRyttY1A0YWFGaUw3U04rZ1JUMSt2ZUxL?=
 =?iso-2022-jp?B?ZlU4bUg0VDM4cEpXMkFlSDNxdEZ4SG9NTmtuU3JjSUovSkdQQWErMkMy?=
 =?iso-2022-jp?B?V1lnRHp6YU85SVRVa2tncExsWDNVOGlYaVZ3UFlRNDFFN0I0MlBWZS85?=
 =?iso-2022-jp?B?d0J0bVlKUENFcXcxNWdIdzRvOEdzWlVnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QlFBR0F4U3p2UHZJaDFIdnRFR05hQytYQkdyUEh3T2wxYVkxZHhVUlRY?=
 =?iso-2022-jp?B?VkMwZXhsTXRtUkhYSVhlMnp1RHNjSXdoOGQ3QlNFVm4zenZsN1UxQUlF?=
 =?iso-2022-jp?B?dmVDYm1PZ0RHSk01bmxCTFRYeHVyWHRjNVloaDd0NVQyZVI0Rld2Vk4v?=
 =?iso-2022-jp?B?clZJbjYyVTM5c0RkalBSVHhXR1o0MkkzRWF6RFErUlp6a0hQUkFZWVBk?=
 =?iso-2022-jp?B?ZUpaYis2QzNhK0VlRXN1TlZMOXFrNXVYM0lJL3E4RHlhR01WbzNvUzRD?=
 =?iso-2022-jp?B?Vis3S25ORldBSGdZRy8ybE5QN2p4czY2V1lIQWxnaExyQkZtYjNxNElx?=
 =?iso-2022-jp?B?VXBTMDd6WXEwVUFqVGR5em9zL2NZUDZXVDRQMk9mOUJlWm85TUpDN0lH?=
 =?iso-2022-jp?B?ODdZb2FNK2hmZVg3byt0RGpiZU9ieUxkVGUwYm9OYTVsaHdBblpEWkla?=
 =?iso-2022-jp?B?SnUrVWFBbTFFZHlKWWpZRjRPOFlPaDQ5dW9IVmp4OFFpUTVXN1liSWZV?=
 =?iso-2022-jp?B?NmMrVnBhZEJRc0pXeEJncHZOR1Z1RzFrT0hOUkpXUEJ6RjdwUjRydkpM?=
 =?iso-2022-jp?B?ZzlNMEVxZk1Ed3JwSHRSZDBpeThwRWRHYWY3Y3FSOCtqT1hxUU5QVjBv?=
 =?iso-2022-jp?B?aE4zMU9DREZETU9VTkxhaXdrL1haN0trVmZadFY0bmdjZFg3RVlKdGRR?=
 =?iso-2022-jp?B?dk9GZzRvZ2xNbUIxSnh4U2hmUDgyaXY3WE15b1huSnFvUXFXdXViM0c2?=
 =?iso-2022-jp?B?S0xyTnZYMUh3TXBDWDVDRkRHdy8zMkhUenR3VTg0bkVkY2VWVTBTS0JL?=
 =?iso-2022-jp?B?M1AyVDREcjd5bWk5SExCUzY4NVVQNEh2eWlFS3ovWHFLR1d5MlZwb2th?=
 =?iso-2022-jp?B?Y3RyNHNQT2NWdzY5ZllyRTFFd0xDdXZMc0lSYWZ1RWkvcm1ucENCNml5?=
 =?iso-2022-jp?B?WWIxSndRdXg2b3J3V3liT0NvMERKY3Q1RSs5VWlrU01ZTlhuWVZXTm40?=
 =?iso-2022-jp?B?TDRFZTJMUElRWXoxRXlwaENkanB4ODJZbHZWejI3R05QUWQzZmQrM2Yx?=
 =?iso-2022-jp?B?dmVjbEZsblY2TVhwdmhxKzVSSXhaaU1iekxTN01DTTQ3SXExTDBqSHNB?=
 =?iso-2022-jp?B?SlV5L1U3bEJVc2puS1hzMUdjdm1iQWw5T1FEa0NtYVBna1kxMEVrNWVt?=
 =?iso-2022-jp?B?QWhXdGYrNjcvbExRZDd4c0wvcmZFdnNSTDJNZkJMTUNZMkJIQ3JzTFk3?=
 =?iso-2022-jp?B?OHhEaytlT0pQYmNOUTlselJyWTBLbUdURWlVcFN4MGxTamdrbVI4QXR0?=
 =?iso-2022-jp?B?cE5TRnpWWWpUTmM2ME41dFgzUDhGamd6NmpRSE9yU1Z3NjVsQ3JlN0pY?=
 =?iso-2022-jp?B?OVpxRnBEM09ZQjArK3dZZ0c1emlVc0hPd2ZRYTZhQVBINEpRYjk0WTFH?=
 =?iso-2022-jp?B?eFBSYk5sZWNwMUYzMGxRc2RYNmhSQWFoc2NlUnpSMlBKYUZVSlV5Y1dQ?=
 =?iso-2022-jp?B?b0VqK1k2bGZ2OUliOFJaNVl2bExSK1NHTFkrcS90c0p4QjZLVS8yRjRP?=
 =?iso-2022-jp?B?SG1YNWp2NzUzQmZZMWR2NkM1NmVEZXhSaWRsWnNSZ1JXWG5iNUhxbGtB?=
 =?iso-2022-jp?B?QVhDeFYyalZhWnVJVnFhbjcwdUNsQlhaYXZZZmpBQUpjaVhFZlVOZTE4?=
 =?iso-2022-jp?B?TGg1SVhFUmNmMTNDU3hEdTBrWTR1eUlUTmZONlBYTjAvMXRpTlhmT0h5?=
 =?iso-2022-jp?B?elBEeGJTalZmZ1FuSjV6VWxWdlhiM0N2WFVYbys0SENwM0JicFg4K1Vi?=
 =?iso-2022-jp?B?UXRXdTgybnNCdWZUaHlXRENoK3FyQUhLNVUrbkNFcXVqeDhYUjdxS2hi?=
 =?iso-2022-jp?B?Q0RBTzFSVFh1VnArTWJhVlVyNjhMOWExWnVYWW9jYmo4VHk3SUJ2ekVv?=
 =?iso-2022-jp?B?YnFka0xJQzRxSElqNG92TWo2eVJoTS9HMCs2K3VDZEx4VEJTcVA2aVRQ?=
 =?iso-2022-jp?B?U282UGc1WTNiUHBxQWwxK3ArSWVkRkdJMEJrcDF4YVF6OWJEL3ZYaklL?=
 =?iso-2022-jp?B?Uk51SkhFOHpkUkprWVdzb3VNMHV5eWZWc2Y0ZUVCSWw2cUlWTStVL3F1?=
 =?iso-2022-jp?B?TDhKUkR2dkY4ZXE5VVYwV21zM0JkbXpIdmRFbE0wZUdmMFYrY0J0QTdV?=
 =?iso-2022-jp?B?a1kyQ1dDWFBpVFJHMWRZaDFLTnp2MWVzTVlUUmRXWkRhQnd1cDZmcWtT?=
 =?iso-2022-jp?B?ZzZSZ2ljNDY5d3RPQUlQa2Q0TzJFWkdiMm9JKzExTkFQcWcxeWp2Z0FF?=
 =?iso-2022-jp?B?NzdiMXg3SDBEMGxBcGZXdFg3dUIyQmtVNnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b506d75f-ea70-4220-1825-08dd3ff1f9ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 23:17:46.8843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f/Ix3zAlRr7TVpZNTd50mQVIuprfIRAgVNWtfbFYpKj+MS3OdIIhhbWO2bRhsNw6xaHU5La6/oSTfaPwKrPMZ7nuqdvcxfeiEZc7VK4sg6P83IGpDu64xNl82rR++wrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8417
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jan 2025 23:18:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17675

Hi Pavel,

> 6.1.127-rt48 was released. I plan to do 6.1.127-cip release and then -cip=
-rt,
> unless someone tells me otherwise.

OK, please release -cip and -cip-rt.
Thanks for your work!

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, January 29, 2025 6:39 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: 6.1.127-rt48, corresponding -cip.
>=20
> Hi!
>=20
> 6.1.127-rt48 was released. I plan to do 6.1.127-cip release and then -cip=
-rt,
> unless someone tells me otherwise.
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


