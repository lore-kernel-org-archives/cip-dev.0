Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05628C433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 08:16:15 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.3023.1637223371928049915
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Nov 2021 00:16:14 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.153, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1AI8FqDR018436;
 Thu, 18 Nov 2021 17:15:52 +0900
X-Iguazu-Qid: 34tMQoLjerxmlIE7RB
X-Iguazu-QSIG: v=2; s=0; t=1637223352; q=34tMQoLjerxmlIE7RB;
 m=qIThZBd+17Bld76ucrVmBDKE7KCg7kbJVizPpg1OByk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1513) id 1AI8Fo8J017376
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Nov 2021 17:15:50 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 356881000F0;
	Thu, 18 Nov 2021 17:15:50 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1AI8Fm2N026536;
	Thu, 18 Nov 2021 17:15:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPdyC64z9dASLHKVBZvHcnre4czKvBN/ZefHZqJcNBHN5OaclX65SAQulfMRfcE2/LcOkNQK0Ol9obrSXA+WTv9uYT2GFjc5fdm/pKmo+tUfKbvassbpmdHqXWiFVhJKKQHVAgeXH+cNj/NsNrWBug0CyxkTmxGZ7fME+ylHyhdPiGmLmyxcxqUFaYVS1S4d/+N29Vte5OPtnPhLqI5Zkn+t6LJqO454SFjmkNVHRi/npKshKT2coNzP2oc7awU2Im9RV948ZBV5VORDeH5HtXVfSWTjh8CRsilDpE/m9Lqhi+8lk+16JSJ37/fYqXLd/ZNZRxTgIFJBTALfy27B0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E0bYOf0FJnwu7axYNpa4OucTEuBplxahNpWMzwcchHU=;
 b=OAMFKIZy6aqHaUbS2O5HohOpqKaNexA3hZFyfUN09Ym82oneF0IzJZ0XprFEPSH2dV1SwHJXp3KBOY7c+n909K8A2V6JLyubIwb5m0+qy9ZopWcYminkIn8qDcD2dBWSasljFwPIezH3NYaMC3PxOiHtM9R/lSPc7dcPWkJGK6si6P7Oi8OsI4pK48K/wvmofwdOC+nuOlAF+BjSweqSMkG08ZZSppaDf7Rfyv0b5yCI4vM6/snhnXgI1lerkGQUA/SxPwdDYQppbBgPN3otVYEStkRM4Ke57rdehQASfKhLMk39tCSspgVo5bD7Wan4NXNjw3nQIfMHOHaRGE9Btg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <uli@fpond.eu>, <cip-dev@lists.cip-project.org>, <pavel@denx.de>
CC: <jan.kiszka@siemens.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: Re: [cip-dev] New kernel patches review management
Thread-Topic: [cip-dev] New kernel patches review management
Thread-Index: AQHX1sVKDSpG8mo8q0i20IN6K0w3L6v+CLCAgAryeKw=
Date: Thu, 18 Nov 2021 08:15:48 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB6252500C44ED67F82CD7EC14929B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <TYAPR01MB6252AE15ABA567A3301A9F4992949@TYAPR01MB6252.jpnprd01.prod.outlook.com>
 <1047231455.163841.1636621461970@webmail.strato.com>
In-Reply-To: <1047231455.163841.1636621461970@webmail.strato.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 2484daba-bd36-b23f-30ea-fb828519a1cf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bfc2028-b3c8-4a16-dd17-08d9aa6ba0e7
x-ms-traffictypediagnostic: TYYPR01MB6666:
x-microsoft-antispam-prvs: 
 <TYYPR01MB666691B8C84F62BD1CF0F8C7929B9@TYYPR01MB6666.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 PJapr8vYZ3bPXGfpjSt2pbUnRNMAA0L20Cp/X4JSQYnUSvNqKEAw33DQ1CtFCu8xgLGFbyRZQ2sNfKwUmIcHjwYfsmdKtuFSYPDCFWqE+9alf1gbsY6grETqx2bGPmRh2hGQwlfhQ6lnrfgeNKDH3yipOHXsjAD5PdCdPFTXDfxsJRQJi6IBU1zov7P6E8/mnLx26btH3IwZDYplAE81IRsKkIJP3WqTaXao1sVc5hPnMY9/wIBQaSPfgNofi9dWJ+CJ314NiOW5uNzys0po6Q6RpwY/9tZL82rmp6ecnhdQ2qSu+s3XY8D8e908zcZpZ13V5NeoaLdGTraaWEgYRMsrJZhJGu+NijvIA1Uzqe49EjQP1Sa4lMYpDnOcxJkPQ0aYjlg0AdOkbloVqww+742z1ol4Wj+TfiPsIpy9wTcrv0UP4xBd5fN8Qjq4fGGCcSpFB/IEkTKEEnmzxbyttgOhLxGtaLuBmzx3vOGsZ0gWrLlflfM1NvXxxCJFsP4xuWGlDkr7y+bEy7jQMsBKiat3L+C5eZuqoqVqHHe/eazlA4kpBJiVKK0KXr+SggVb+UhTT+t06oaPEDKiENnm+qTQHcPcAB27Ar7SM+ueWZf3jfoKLKplYXrYUUf1f7iA0PmJUghICSzP2z0LmlLhKk5IMtoXAKiJgj/SxkPpMymv8hqIyyuVeiHGocUizv2zSgIK+hNNpvg81zde0Mk1iw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(186003)(71200400001)(66574015)(8676002)(64756008)(76116006)(110136005)(66476007)(9686003)(7696005)(54906003)(86362001)(8936002)(316002)(53546011)(508600001)(38070700005)(5660300002)(2906002)(55016002)(66556008)(66946007)(26005)(38100700002)(122000001)(33656002)(4326008)(6506007)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c0lTN09Pc1lON1p6VXJRVmNSTzZiWStJV21tTWRnMDI5RXBqYm1BMFdF?=
 =?iso-2022-jp?B?SmI2b1hxN1loSUdQbDJ2eVRNcHoxUXN2Q01kV2FiTVdhSjJFOXZpZCs2?=
 =?iso-2022-jp?B?L2dLMnFDWWJuKzRqbnBSOUJPR2hjUEprbFoxUjduN2lLMFJ2WGhIcWxn?=
 =?iso-2022-jp?B?THJsWWJnUVA2VklPU0haNC9ndk1hZURVemkyRjBSVUgwL3FwSlJWTHhD?=
 =?iso-2022-jp?B?dGtMVzRSY2xOVGRjYTMvZUt0Qkw5SFNuaHpUYzczclAyaG5Yd1lIZE9w?=
 =?iso-2022-jp?B?N3BWeis4NkxTcnRuUHpzQWx5ZnFIWUxNNysrWEdYcHhrTnRPUTl3VmZR?=
 =?iso-2022-jp?B?d1JtUlFjWk5FOXVITm0vci9EbHJCN3pLN3ZPL05ubXhwdWdyU3VrQTZY?=
 =?iso-2022-jp?B?ZXA2NlF5allNQXVrZkR6ZmtTcEl2ZEVTQk5SbUFkYy81V215WkhnU1ps?=
 =?iso-2022-jp?B?R2xUc0xPSXgwRm0zTnFwbUpjTUVFUUgrTFNIMlE3U056azI2d2ZKa0o2?=
 =?iso-2022-jp?B?QUZyS1V6WUFwMFFFNE53MmZDU1I2Z01yNVN6WHJBREg2ckhSV1ZTSUZ1?=
 =?iso-2022-jp?B?bDFiNXF3azFnWnVZNWlqYVYvNVZiSkNDTUU4SzE3NHJqbVhaOFBUeDh5?=
 =?iso-2022-jp?B?QjdwVUl5VUoralZBbUg0YjhZQkkzSjhBWjNMbFMzb3gvcXhXZjYrakFL?=
 =?iso-2022-jp?B?N1ZXQmZZY0IyaVR2WjluRHpkUWZRTWhNMVlFZmo2SHZmcnhwMDJnTndu?=
 =?iso-2022-jp?B?R1NxZk9vYVV1NG5FVU90U08wZkgvWGErcjlHc3hmYmdWSUFSeUdqVE5y?=
 =?iso-2022-jp?B?cHRUUmRGU3ZJZmI0R0N4NXp2MkNLNEFtdDA0Y0o1V1dwbXV2ajVjdU05?=
 =?iso-2022-jp?B?TVZ4a1FzS21KSExmQzBsRnkyMjAyejdjZmJNdGFvT3ltdVoyQjBHazRP?=
 =?iso-2022-jp?B?MVAzcWd5YkpmYUNSR3B5ZlNEVzY4NzNJaW1xUkFMY09nNkVmYXlFUVA2?=
 =?iso-2022-jp?B?bmlKWnZySnUwM2l0R2hIMFNHOVo1V3FjZy91N2Q0MjJjNzNCNjZ3K29V?=
 =?iso-2022-jp?B?aXBWdWdFWmpsSndTeElqMHlhckdXaU5hUEJYdHZLL2dJdGNKVVZkZmlj?=
 =?iso-2022-jp?B?b21aOFNPNFRnZDk4ZHhNOHE5Tk42bEhBU0pYZnN0aldNSjl2Z1ljREFj?=
 =?iso-2022-jp?B?UU85emMzQnMxQXBVTVVIdG1HQmVWVktjMk5OYUJsTnYxNU9KaWJBTVRw?=
 =?iso-2022-jp?B?UGhpS0l0QklVZVpTZkdpMmR0U29kQzZvem9NallFdDJ2VmdDLzZEbld0?=
 =?iso-2022-jp?B?NXVseVV2UzZtZ0FrQWh6bVVhRXl3dXBFZjU3TVphMVFOZjhBMGtKbHhy?=
 =?iso-2022-jp?B?ZTJ5dy9WREJLSmJzZUlsWThYQVBoZEZuUW1wU2dpZnMrbzJjWmlsNzVv?=
 =?iso-2022-jp?B?OHc0RjdDVzlYVDNlZEV2K3ZDMEJNZVNpZzROL250V0w2V3U1NC9TRGV2?=
 =?iso-2022-jp?B?T3ZNdGF2a0k4MG9OMlpMbE1EQTNzLzVpc3R1am1nVVR1YUxRcHMwNTJL?=
 =?iso-2022-jp?B?QjNHQ1BJNm1idVZyeGtSSytucUxNdVNhK0I2R0U3NzJua3o0cFJ5Mnhj?=
 =?iso-2022-jp?B?ZktxQ3UyQTdlZGQ1U0U1R0k0WnlGcE9oSDRBeHdIbW1xdk5nT2hJc3lZ?=
 =?iso-2022-jp?B?S0dtV01GdDFlMm5IMmxOa2VpZTB4M1pUUVplZ2I1aE9uOFYvekJnc004?=
 =?iso-2022-jp?B?WW5lek1MRFE2MWdiakU0S3U5M3Q1RkE0WHQyTG5FWEtUcnIzeTdqUjUx?=
 =?iso-2022-jp?B?NVIwK0NWQlczV3p1WkdYNzBLRStZdkpHbkxPTmR2ejBUbWN4NlhQcEdQ?=
 =?iso-2022-jp?B?ZDVDRWR4amZtNUptdXUxUDRNdkswRG1kaWVHd0gzTGd2d3lxbmtLbTZp?=
 =?iso-2022-jp?B?QWMvUzNocHozMnlDQkUyVlNPcWxFalFPdUpodGZUUVpKWlQxSEVqTFcy?=
 =?iso-2022-jp?B?TlE1Y3dQckU4UnhwN3RTeEl6RlJLNHBRUGVhRjB0OGtUWmVBcW1UU2NH?=
 =?iso-2022-jp?B?NXpZa3FRNXdNTVVITGxCZ1VOZ0ppQitSbDY1aXg3SVk4R2pxTlJwbjUw?=
 =?iso-2022-jp?B?TXEwT2ppMEw4VTJvY05qRzVaazF4UDRuSy9vd0JxZ09udEUzUXJrdVNQ?=
 =?iso-2022-jp?B?b094VWFJcUVmbzNvMEs3SXhOWVJuaGFaa0dKSWpNaWlIZFdWK3BwTXVr?=
 =?iso-2022-jp?B?K0dVZXF6NTJKTEE4dHYvTnZiaWFmbjAxbFAvdnJKZmRDTkg2amFTeEdV?=
 =?iso-2022-jp?B?V3hYeFAraW1neGZuSE8vMXg0MHVwTHk2NzFwRXBpZWFRU2x0ZzJtZnp2?=
 =?iso-2022-jp?B?NDhWZ1pQMVRhMlZjblJNc2x6NmtHOEpWbEVOWmtkMXIvMVpRamU3cTZD?=
 =?iso-2022-jp?B?RmUzL3ozWGN0UVpudEozOS80YnAxaExOMmpEbE4xdGF2S1IwdDhEem9y?=
 =?iso-2022-jp?B?cXFZbDJ6?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2bfc2028-b3c8-4a16-dd17-08d9aa6ba0e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 08:15:48.6860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 q4wGlpeMfJedfwRlf0SPyOUvbEH5Dfo92DB5wLSxBQM1+EyjVHAaXMvAkbdLychsrcHQY+O+lJG/Eumn6s0cyX7jHJe3kyIwKKX6L/Ulk9BTtyr8IBT8qMOUomPva3E4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6666
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Nov 2021 08:16:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6951

Hi Ulrich, =0A=
=0A=
>> The commit content of [1] is an example, so please let me know if you=0A=
>> have any opinions about the format and others.=0A=
> =0A=
> It would be helpful if each line would also contain the commit title.=0A=
=0A=
I agree.=0A=
=0A=
> Other than that it looks good to me.=0A=
=0A=
Thanks!=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: Ulrich Hecht <uli@fpond.eu>=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B11=1B$B7n=1B(B11=1B$BF|=1B(B 18:04=0A=
=1B$B08@h=1B(B: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=
=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=1B(B); pavel@denx.de=0A=
CC: jan.kiszka@siemens.com; masami.ichikawa@cybertrust.co.jp=0A=
=1B$B7oL>=1B(B: Re: [cip-dev] New kernel patches review management=0A=
=0A=
=0A=
> On 11/11/2021 7:29 AM Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp=
> wrote:=0A=
> I considered using the gitlab wiki to switch the current patch review=0A=
> management to another.=0A=
>=0A=
> The gitlab wiki can be used as a regular git repository and can be=0A=
> viewed from his browser by writing its contents in markdown.=0A=
>=0A=
>   e.g. git clone git@gitlab.com:cip-project/cip-kernel/linux-cip.wiki.git=
=0A=
>=0A=
> It can be created using the API on the project wiki[0]. Since=0A=
> namespaces are available, we can also create hierarchies such as=0A=
> 5.10.y/v5.10.77 [1].=0A=
> The wiki page is first filled with the commit ID, then the CIP kernel=0A=
> developer writes the name after the commit they plan to review.=0A=
>=0A=
> The commit content of [1] is an example, so please let me know if you=0A=
> have any opinions about the format and others.=0A=
=0A=
It would be helpful if each line would also contain the commit title.=0A=
Other than that it looks good to me.=0A=
=0A=
CU=0A=
Uli=0A=


