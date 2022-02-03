Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2BEC433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 07:13:34 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web12.6141.1643872412620280540
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Feb 2022 23:13:34 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 2137DT8l029512;
 Thu, 3 Feb 2022 16:13:29 +0900
X-Iguazu-Qid: 2wGr1UbX7IihmjwolM
X-Iguazu-QSIG: v=2; s=0; t=1643872409; q=2wGr1UbX7IihmjwolM;
 m=Iv7sDmQuKUbcwEWNNCb0SrXJ1CNuJXpsFZjdtPB7hu0=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1112) id 2137DREF035395
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 3 Feb 2022 16:13:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQpLXq6mEykcHv065QayJ6Pf+r0kotMleXVyzJsMAKw5NmERBeP1JHiXg48nbI6XAAJjA1AmLbS+NAD2aMPAEjXlPSnm7JeJOT83skaAbCVwQLS5CksjmZwvYOCD25Uk9TF4CFB6sj4Ii9JQp4Iowp8pa4y2z/KlW1oE01bTeg3fQsSvymdXmoIertTc1h2f3lrVU6JdjBEEjCnbPjLDBCluLKSfBwBSVkSO4wmo/GzMO1EtOX6n8vsl98Fo+tvQSpRFatbcaMYmSA5/FTOVwI/14R06Bjhiv9OqdSU21PAglhwB24WtOjM4DcY9JgknGtY7lv6CfvlIrtND98x5Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEpjGo8pBqjYJG490HOBPjZ71jETtmKeW+n3co4rPTc=;
 b=N6JjfQEq2JlX/+9sU6cZJvtlw2J4aGeSsofi3UF5yFkN/xEVumhMGYiD7A8DPUAmpWSGoLQpVGPdwHI6QEvLe2bpPDcjD+DA2XWD7v9w5DaUXkZbikTYE4laro3ZQxkKahZgThTx1E3ZBkYUJxJF4UjrvlKWKcHxVyWtboumveG87TjW+6VL/Ah60Tvq+8XCJB40NgtLxpCQ0LIqQR3EGQmyKPyR4nrjprY9X3jF//Oezp7Md8qkrakelNVaCrqr7VZpp15m9GxtaHLB6GbX/qLshNVRn3z/9YYebykGjtfTWr6tx78vgOAdZPogsQ6L1A9j62J4IXpkUdECe2a8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Topic: [cip-dev] 4.4.302 is going to be last 4.4 release
Thread-Index: AQHYF7NSNLjndOJvkEGi8B835wYXW6yBaoYQ
Date: Thu, 3 Feb 2022 07:13:25 +0000
X-TSB-HOP: ON
X-TSB-HOP2: ON
Message-ID: 
 <TYAPR01MB625279122E073EFF486368C392289@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20220201213254.GA3001@duo.ucw.cz>
In-Reply-To: <20220201213254.GA3001@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 785205ce-1052-4776-f17e-08d9e6e4ab84
x-ms-traffictypediagnostic: TYAPR01MB3502:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB350286A45694C57CC067335F92289@TYAPR01MB3502.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DtoUV1AjAB/z/Kl+lTNkVmB0GKCePZnKP5800d1QHnSTAG5mIHvRo7VdG0viB47gdVsar381g7yC4bJTi5HqRiW5iKCecEeJQy5uADfrYchywiRAagIiSDOtrZdpHRlKJkyExeZalpvHSx4CWQrXAeRFSxnYB8TsasGyXxY3l7C5IUClMa1OWB7iGQsEttrEX3yuMGiX4+wLFuj+RK6aHMQQpzvYVE5nWV2BRMhGXTauQv6BNvs7Ns+GB/Uwbbrrl9zQHlTF4REY95LpeTUTrTBE/tt5Rt9z31RgZs86K1gFeLEfp3f2d29z3EFggaqcKQqDJL9s64xepQAQq/7NvykQfSOOAshvxjy035eXZV2SP8zwK/h7ESkDMt3AwMD8bH+PP0bCOMYC6SpRBFUCy056ouoj8v+YzVRWGX85PSCiXMUNh5pHQRVdDpGUv88ntdJAiCVll9vAGczxzZiF0qRguWhQzcS/4+DlVZDolf2cLpaA9US6iy+vutbV9UCkoayZPByTHoLbUxPz+A8h/IC4LB6MbUZAd/0XucT9AnzrKNLUon8UmRaoO4366kcEmZfKJfttylDh2aHg+of8kDXOOD/0WwooT3MhloGXhG/jxzXR8P4P93+0y2jd9Q45eMyeXSH+aeFf65j7gNjpwTwoLtdhmihuB/F0uYaedbuk0RmiRhMMyPFDRd9NsFtwC+mOZZxMR0nuYf3518U+cQ/jOWFZ+pMCzrudHo8whi12Dc1XzFtLmi5mq9V1KRBJI1pTHqjMilx0nly1GfCWuobd2mF5mS80SJi+L4njnoI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(76116006)(5660300002)(52536014)(9686003)(66446008)(64756008)(71200400001)(7696005)(8936002)(6506007)(66946007)(66476007)(66556008)(53546011)(26005)(186003)(508600001)(316002)(966005)(83380400001)(38100700002)(86362001)(38070700005)(33656002)(122000001)(2906002)(110136005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OFRtaDZqSjM3VENXQXlnaVpMUkE0RlFwdjNXVE5MbHExSnNoc3dwbmlz?=
 =?iso-2022-jp?B?cGRoUHY0VEpSR0VldVk1MmRCSGs4TkZ5Z2J1bjBsaU9YZEM5dGhodGly?=
 =?iso-2022-jp?B?VEVsYXFJSDJieXNyMitNMWU1MWVoK1VTNXdjVzN4Yk5UVWpWalFHKzdm?=
 =?iso-2022-jp?B?bnc3UnpZdXFUQWxUNStyamVOeHo3bFFGUm5ldGwrTTl4MjZ1RVhCblhY?=
 =?iso-2022-jp?B?dzgwOTl1YlNYdmFXQUlpUG5GUmo1OWZ3Zk0weHJ5VUp4MDV1WEZLSWdy?=
 =?iso-2022-jp?B?eC9lM3ZaSVM5SXVBWWVqdXE2Z1lzbUd3cEZ5OEg5U3VMbzd4RXdjZGdB?=
 =?iso-2022-jp?B?WDVTWXZXMysya3FnbnQ0b1RhV2g0d3pkSGlLU0RORTNJNFFmRStlSG9l?=
 =?iso-2022-jp?B?eXNrTm5jV2VzcitndVlWOHRqVS96U0tYUUFORVFvT256RTlZTUNOdXd3?=
 =?iso-2022-jp?B?dkZQTllvRUFXM2JkelI4YmVMYWt1VmlZSFNJb1J5aXVxemwwQ01UUGdT?=
 =?iso-2022-jp?B?ZDd2ZEduQVRUTjZDVHNHRkJ6SlRPODBPRE95cmpROG5IOEx3SXpqYkNz?=
 =?iso-2022-jp?B?N0FxR015YnRUeFFROE1wWnIwWmZ0MTkzTXI2S3lYSmQ3V3B4SVZJRGxx?=
 =?iso-2022-jp?B?RUt4cExGL3BSREoyZGNzUnRReDRieUppM21Jbzd2blZhWFRlSkdyNmk5?=
 =?iso-2022-jp?B?NC9iT2NybjQyckMvTE4reXZ4MHRuQ0hBU3JPaStOc3VNZUNxbERpamFE?=
 =?iso-2022-jp?B?UGNFdGZUNmRLdzJRWEhuRzgwczZEZGFtcHkwOVp4S0FzVy9Wb3dUWW95?=
 =?iso-2022-jp?B?S2VIaUI0bVF4aEhiNDUxVVEvbnJRR0tVWFNFZGNWKzhOaExmWXFKa09J?=
 =?iso-2022-jp?B?ZkZYeTdlTk9oclo2Ump4cDNpQjk5VmQ2ZW9HVXVNL2ZGSmY1ZzYyL3cx?=
 =?iso-2022-jp?B?N3Qzb1dGOWhsM3JILzExY2kyMzRPTUpXU3FKaDVqaUNtMC9scW5UQk1E?=
 =?iso-2022-jp?B?TFB0dnVpcWF1aE5Ebys1Rnd4L3dncXlHMjVmT1NyeHdzT1FxeGFneGx6?=
 =?iso-2022-jp?B?UG9EcmlhVlAyZFZnaWk4T0ZEN3picVBiMmVzNEdYaSs1YXlzTUtpb2Vw?=
 =?iso-2022-jp?B?aUpGcFlmM2h6QXVJOElnU21nbGJnUXFaaEkxT2FyL1Q1eUZSK2xkOTFD?=
 =?iso-2022-jp?B?dGlUOWxkMUdSNVYvZXBZY2pXRjJUWWhWMU8xWUtya2U1K2ZhVWhURXlR?=
 =?iso-2022-jp?B?cEVjbGxuRkI4RHNhdXBnVDhlYTlKaEVPOTNHbjhvT29pRWNjS1ppKzcr?=
 =?iso-2022-jp?B?ZUdadHdOeTc1Q0I0eExKZ25RVGFRcUFLT1REUlJnbHdreGpuWkNYRjNU?=
 =?iso-2022-jp?B?N3p5Q0QxSk4wU1phb2Z5OHM5YnhTMlRrclUzMTkvUVgvRHNwV0hMRk82?=
 =?iso-2022-jp?B?aXhpSEc4ckpOUEhQTTQ1dkJ6bm5pTlNiak9xSk5ib0hJMDlGN3JMUUN4?=
 =?iso-2022-jp?B?a0V1KzJTSGkxMjlDNnJoM2tkaGdMK0tCdFNNTU10RkRhNGZjbGl6YjNF?=
 =?iso-2022-jp?B?WTZGZXNYbEZpb0ZYU0p0NG1HWnRpYXdvcWthQU1TRVFnMDlsNGhhZ2RB?=
 =?iso-2022-jp?B?ZDIzb1RHekMzOFdLNWxmTGhtUzlzWjBXSUZoS0FpaUZNWm15eHpGeVF3?=
 =?iso-2022-jp?B?N1JQSTRsRUZ3TzlZaVNacDFxVldhZ25RN3FKWWVOQmV2S1V3L3hPZTNk?=
 =?iso-2022-jp?B?Q0N4RytrU044RU0yRUFIV3lERUNFLzVYT0ROcmVwbk1iWGhvQ1ZWR0Jz?=
 =?iso-2022-jp?B?b2E3MXlIRjhKaFZXd1V1bXZ4OVcyYWN3d3MxUkd4VkI0V2ZucTZuMUdK?=
 =?iso-2022-jp?B?TlN5bEZ4ZVBqZTZKcUdHVk4zelpzSG9MY0pIM2JyNklDY1FXNWZqUnZ1?=
 =?iso-2022-jp?B?ZXJrQ29Hc3lXQVlISDlZK3hvcXpvOStzUEV3S3V3UFNoaHo3YkN3K0o5?=
 =?iso-2022-jp?B?V1UzUWUzNzFiaXBQTjlXZE82V1pKQ0RIb1JCbW1iVWM1UEN0L2ZmVHZY?=
 =?iso-2022-jp?B?NzFuZnFKOTVtaC9xNTFOMVFQYVRsTWFtbUZGUThmMlR2dWc0bEVIY09J?=
 =?iso-2022-jp?B?RG5xak9KTjNZTU9ualY3VXlIRGdrT2JKendUTjNYamxJMFVRTVNPWDdW?=
 =?iso-2022-jp?B?aGh3S2psQ2ZVV2U1aXdvWUFaL1NNMUU1Zm1heWxmVlFEM1JPQnV5elV6?=
 =?iso-2022-jp?B?cHYvUHBRNnA0UzBnVmQ4ZHlqcFMrZHh6R3BPL1JMVk9BdHJCeWlEZUFm?=
 =?iso-2022-jp?B?TjEwNE9LVi84amZwaktuT1RzcEJVNyszM0VjNzhxY2owNVlpY2VoYzJz?=
 =?iso-2022-jp?B?SGxhRGRYYnVobnM2T0JDZTNteXR3THFRaHMyYWMyaDdMZHN5VitydGV6?=
 =?iso-2022-jp?B?L2F0b2YrV1Zrb1QyVjRLandrbnBMaHJ6ZkpGSUVhWlVwL0RCSER5eExK?=
 =?iso-2022-jp?B?dlhKWXhm?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 785205ce-1052-4776-f17e-08d9e6e4ab84
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 07:13:25.3403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 VcYCD9wKULu7wIncGGeph1XdCRHJbu1RmCGgZu4hHbqXdsh3cq+zQj1jBMqku4mjPgUCqgRtWftwE/EsAg979lgMN4PyDQT2kKymTawbB6T01i7gd4bizIF57fnaYfB9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3502
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Feb 2022 07:13:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7567

Hi Pavel,
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Wednesday, February 2, 2022 6:33 AM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
> Subject: [cip-dev] 4.4.302 is going to be last 4.4 release
>=20
> Hi!
>=20
> Greg says:
>=20
> # Message-Id: <20220201180822.148370751@linuxfoundation.org>
> # Subject: [PATCH 4.4 00/25] 4.4.302-rc1 review # ...
> # NOTE!  This is the proposed LAST 4.4.y kernel release to happen under #=
 the
> rules of the normal stable kernel releases.  After this one, it will # be=
 marked
> End-Of-Life as it has been 6 years and you really should know # better by=
 now
> and have moved to a newer kernel tree.  After this one, no # more securit=
y fixes
> will be backported and you will end up with an # insecure system over tim=
e.
> # ...
> # Responses should be made by Thu, 03 Feb 2022 18:08:10 +0000.
> # Anything received after that time might be too late.
>=20
> (He sometimes releases kernels before the deadline).
>=20
> We may want to make any announcements now or just after 4.4.302 is
> released... so I guess we should start working on suitable wording.
>=20
> Something like:
>=20
> CIP project is committed to maintain 4.4.x kernel till January of 2027 [1=
]. We are
> maintaining -cip branch [2], that is stable kernel with about
> 1000 of patches to support our reference hardware [3] and -cip-rt branch,=
 with
> is merge of -rt and -cip trees.
>=20
> If you for some reason need 4.4.x with bug and security fixes, and are ru=
nning
> similar hardware to our reference hardware (x86-64 and armv7), -cip tree =
may
> be good base for that work. Testing of the -cip tree is welcome, as is jo=
ining the
> CIP project.
>=20
> [1] https://wiki.linuxfoundation.org/civilinfrastructureplatform/start
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-cip-rt
> [3]
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/c=
iprefe
> rencehardware

Thank you for taking up the issue. I think the content is fine.
BTW, do you have any future information about the RT kernel team?
We may also need to check the RT patch.
If you don't have the information, I'll ask the RT team about this.

Best regards,
  Nobuhiro


>=20
> ?
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


