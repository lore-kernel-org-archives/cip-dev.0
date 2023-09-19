Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C717CD5BA3
	for <webhook@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.6790.1695125307265660505
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 05:08:28 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 38JC81Lv3620352; Tue, 19 Sep 2023 21:08:02 +0900
X-Iguazu-Qid: 2rWgyA9op3oXB2UY5q
X-Iguazu-QSIG: v=2; s=0; t=1695125281; q=2rWgyA9op3oXB2UY5q; m=Pe4RqK/RCyecXVn2M8KUq0gdR9mz8tbiG8TF/wSbB8I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 38JC7vMl2770660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 19 Sep 2023 21:07:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDDV1xbNGN6ubHtixqPqwJahvhqionJszL6hwkDKKSQIEwlTmdlQHYlqgIAD58dVjwBZn0L419GmAa7iIkY2O737A70uhRmRAdDSVpEq/FgqwTOW1I1cHIBizcFkiuTiV9hgmxSdBq0xYU95O+/7cCju+WfEKG2PKPk2EwxA2x3w+ncU95F0H7z3PglUNHxOMCkcnKvti7SSkmj2/w9bj+qsAdbIGCa/27lN6YYjg3+wVhWsdaLcSkmWwhRngFXgD9spHPT5o7cMeJSJ4Ae6OrYfwV2+J5p39B0qqYHtoo6oDAYIWEbl+BwZc4+m0o2V7n9fHIGcOQh9F2No10aJvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=APyI0nwzLhBKesEl1okOkSHWcCqX9OGWvjTZy+r+JqY=;
 b=ATHMSsJhnIdcbVk5XiCWeozajG6PC/ZQLObGgIqx9Q2elq5BIQsk7jSAdqfaRzwdvN0ROp9cvHcSl7XXGgG4PUX3cprqFXlHGjzM9in8RN9GBZvjRJ2gyEhfX0TpAgDFAxoCJriyUiIbeNj9n/BWNo1zFH1AxHv9PkBBMspZskWva1H4xKqbHd0MYnMRcP8n7LbyQV5TXrViuhm5kuoNOPN6By8isk8f+8FVY/scYVCJh/Zdvq2Chbzdujsbp2PSql8B55+8igGZLWg3f4PjJIOP/1IOmRoQgCgR1w8Ubdl2oFMCvvQtbCcjgKvfbWr4XWYTd+gjR40+MzCbHLhpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <masami.ichikawa@cybertrust.co.jp>, <Chris.Paterson2@renesas.com>
Subject: [ANNOUNCE] Release v5.10.194-cip39
Thread-Topic: [ANNOUNCE] Release v5.10.194-cip39
Thread-Index: Adnq8bl7whuogWpjQ6GDs4st3ouSug==
Date: Tue, 19 Sep 2023 12:07:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420C4F2D1A4D50470E0E5CA92FAA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5904:EE_
x-ms-office365-filtering-correlation-id: d81e944b-63fa-4f97-4632-08dbb9090e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 CrTKLSKtq1bFtEOcpn3zeNmSt0KLPYtD8Lf5uImJ3J3CUOWjhVsKyRA8TXp9TTBXZY4mEEzp3a+5ZPcl5uQs4vdkapQW9DZe7blyZmLBRs/ueOAld9K4x3FYoI/B066K4K43bRdOg0vQcg9jW8dFp71bvpwtlci9E40PU8PKoccqWJmT6jS6OzVP/51tj3KUui2i7aU4eolq6Y5VM2qYO8PHoMwNymw9Mui5RCxdExyphVh2ePYe3NIihR+M3hgQKKrrkPdSBU+aHV1zjiCc632Sji5jonCkWEo/QcHme7B0iQh6VMd8ao+iNooEyOujvxhalBRwxmNtk0ETMqthuNn9YtwFEe6Y6Js5erSobFrhWl+j4aW3O3Txh6eT+iFl+W8Per88vJcuQ+crrVVO7JvESPyEWWwE1urJbFlx23nIRyn8id64k4rcEyY8UXH73lEro1fPLRvmTSDxMx/Cm6hVqLPlxo4/HbJI/lKR2FVzkJ/jH8UaNEWO1JUKUP66odjSJqZI6xWPH5itq6vv9rnlUYV+6pV7Pd6oUDDhRrZ6HpGgiPUU7MNahkxxznYIwmNhXsQGqfJhB84aabIS1DOMGgEMHlytLW6bk4Trnzdae3xPF3GOmLYcVBOxcB7OWN++hV/xAcP54yxLzuEpYg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(1800799009)(186009)(451199024)(55016003)(71200400001)(122000001)(54906003)(38100700002)(8936002)(4326008)(8676002)(38070700005)(33656002)(76116006)(9686003)(66946007)(41300700001)(64756008)(66476007)(66446008)(66556008)(6916009)(86362001)(316002)(2906002)(83380400001)(5660300002)(26005)(7696005)(52536014)(6506007)(478600001)(966005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eUZYa1pVTVlZZmJ2TnM1UDljQmZBY2pUZjMxWHIyMnZzTGUrc3RhMkY1?=
 =?iso-2022-jp?B?OEY5NFpvWk9LT2J5bWtnRXVrb1JYRDMxYUVrb2t3Z2Z1ODFmVCt5VG9S?=
 =?iso-2022-jp?B?d2Y4VDEwOUwvcStVemQ0UHM3ME1YSGxCRk5ySFpBVlpjenJCb3dIeCt3?=
 =?iso-2022-jp?B?anZvWXVsSWVNRVFXenNZMkQ2aWJuZEl4ZjlJZTY5YXJxWlJQRjFCc244?=
 =?iso-2022-jp?B?M1FtblNISUlrTFZ4YkxzaC9qMkNkT3JmUUVEV2EwQnJrK3JPYlN1L0Fv?=
 =?iso-2022-jp?B?djVYT1dHTS9YN0VXbzlUUWxYTUdJakRDWGJnZWw0RGtWUUVzRDRqQVFK?=
 =?iso-2022-jp?B?bEwzd1NxRlY0eVJ2R1VZR1pjYmo0bWxrSHIwanpFMUMraC9YWnNmMW45?=
 =?iso-2022-jp?B?UmxSM1BQQ0R3WjZhVWhSSmRnMm9jbTd4cmN1V0xwUndaTUZ3Z2loeGox?=
 =?iso-2022-jp?B?NmxGbFJYaWN6NHpBRDJHNnVRSW1NNzhESkIzMm9yZnB4SGJjY2RVRWJh?=
 =?iso-2022-jp?B?eWU4YUdYUDRlemtjUmJTS1VGSkE5SHBaRDlyZm5vU29Ua3ZwSG1tL0hj?=
 =?iso-2022-jp?B?QVFaSUkyckZXaVUrTElPNFJySVdzN2R0a1RHVUpNYmJheElwcW9MQlVh?=
 =?iso-2022-jp?B?R2JOejlRN2lHcnFIYXBXQjdYdUFWY2VuZDFLek1hYUhFM0FORVU5ODU2?=
 =?iso-2022-jp?B?Tm5KWXZ0WW1jaGdyd0gxcFpzUm9MTjFKYjVmNmhiT1RtL3A3cHRoZUZE?=
 =?iso-2022-jp?B?QzdWWWVkRDRVVWtrQnRxMFlLcVlOb1lyWCtsTUdtbzFHZjhYck4vY2Ey?=
 =?iso-2022-jp?B?akF2M2lwMk5mWE0wbjUzaUNUU3pQbGk5dE9RbXUvb3hXVFhHN1doV1FL?=
 =?iso-2022-jp?B?RHp1K2g3bCtpOWtaTVNuaHpwa3FjVjNPWjB4S3lPb3ZwL3NuRU92M2hL?=
 =?iso-2022-jp?B?R2ROY1NVeUJnSzhrMU13Si9MeWlSN0pTR0pWclZvT0JwNUJyR2xsdjZl?=
 =?iso-2022-jp?B?R1FKckRwNWdsYWxEZksxYmFscUJha3FRQ2F2bGl1RTZiWUZlM2dDZUNB?=
 =?iso-2022-jp?B?c1ZIT1Z6UzF6Vy9wa29OaG9ZSzBuU2U1VVJ4SkJic1U3eExpSVQ4ZVp4?=
 =?iso-2022-jp?B?SGF4MURObHU2c3JFQ0NKazQ3dFhkdHVmbFNmcTJaajBPUm4wZnk2b01v?=
 =?iso-2022-jp?B?aTk0NmF2aXIxcWFKQisxSDdJSm02VzRVeTBwWmxmZDNUU2tvUURXUUUr?=
 =?iso-2022-jp?B?SmV2eDIybWhWc2hWbTlFcnRQb05GVm9MRHdxYSttSUJsY0NlcnMrM1BB?=
 =?iso-2022-jp?B?Q2lhQ2FMbmhxZXh3K0R0dzBia2JpbTA5SnJwQXY5R09vQzFuZU16d3JF?=
 =?iso-2022-jp?B?TmJmOHU2SFp1N1RjUjVyRXdMZEs3YmNVL2tPU0QxdDBIZ2pqTE10dWFn?=
 =?iso-2022-jp?B?RG5Bc3QydmE2UmtGVGhmREZ1RWJLaTFBcTJRQjlBMm83dHR1RXdJYUdt?=
 =?iso-2022-jp?B?cThjU0JxZm9vZGpiTVBGbXJtMlJjci9pZjR3QXJyaEJJNGpXbG5UeGpz?=
 =?iso-2022-jp?B?UkkyMkdEYWpTa0k0RS84UnQrRDF3SExnQW5WRkRTV1VCOWhqU1Rhbkcx?=
 =?iso-2022-jp?B?amdNVFQ3NGtZOFpWS3NrU2VXRUZPc3N2SGRaOElTSkdqWWJ2aFA4NU9N?=
 =?iso-2022-jp?B?eklPZk9MOU1KZzdEczhqM2d3dFR5VFV4dFkvTGxYMkFUTThuc3YvaDJW?=
 =?iso-2022-jp?B?RVdyenEwSmszbnlSSGFRYVlVTU4vaXI5U2tpanF4UHpPRnc0akhpdnp2?=
 =?iso-2022-jp?B?ajNxQ2dsNUxxanpYd1FxNFdTR01IOVNrQU43dFArRkF2cERtOGd5Y3Fo?=
 =?iso-2022-jp?B?eVdyRTgzZmVYTksyL04yNXRCejNiSG8wRDdxbGR0M1dOZ0JlWjdSWnRh?=
 =?iso-2022-jp?B?UDd0L0lDYTdFR1IvVEJQbHcvWU1CVStXM2VUeWpjMW4zVWhXME1YUVBH?=
 =?iso-2022-jp?B?WjdaRGVWVVVPdjZ1UXd4d29CNXBzVzZqU2RPYXNjSWNhZjRUQWVvbFN0?=
 =?iso-2022-jp?B?L1lCUzBpc3V0NmNBNFp1YS91enBtdE04NXFKMXVIL2tmNzlXaDRIc09j?=
 =?iso-2022-jp?B?MjNjbDNRUEpGellKUlAwUThDbTQvOTRXSkJKeU1iWVB1UVBrb1RORkFI?=
 =?iso-2022-jp?B?cURCS0xDUVR3MzAxbWdqTHlCMEZ6NG5oWjNjbGpWSzEvbjZ3amFQT1RT?=
 =?iso-2022-jp?B?SUNabCtMWFVQN2w1OENmQy9URGdUZ0hjRSs3QkIrUDZlNU5nQllrK2lF?=
 =?iso-2022-jp?B?TnF4NW9qTnBPZ1BSanBmVVFpbU0wcUNGVEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e944b-63fa-4f97-4632-08dbb9090e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 12:07:54.9361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UQu43WHZGsEHCuvXmQto0Ss1iZklQgqRxuZXCSniZvUPBIU98yePG9tiT9J6vHzrQ4L4s2dNKNSKTYISOUcdMrhz//CXQC4mD4xB6BWFhrw4tPlrbcJCbL2tWocd3Obm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Sep 2023 12:08:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13145

Hi all,

CIP kernel team has released Linux kernel v5.10.194-cip39.
The linux-5.10.y-cip tree has been updated base version from v5.10.191 to
v5.10.194. In addition to updating the base stable version, this release in=
cludes
bug fix, RTC and MTU patches for Renesas ARM64 SoC.

You can get this release via the git tree at:

  v5.10.194-cip39:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      ecda23c2ad8c5eae1f19054d0b67a7904546b7f4
    Fixed CVEs:
      CVE-2023-4622: af_unix: Fix null-ptr-deref in unix_stream_sendpage().
      CVE-2023-3773: xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
      CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params
      CVE-2023-20588: x86/CPU/AMD: Do not leak quotient data after a divisi=
on by 0
    added commits:
      CIP: Bump version suffix to -cip39 after merge from stable
      arm64: dts: renesas: rzg2lc-smarc: Add support for enabling MTU3
      arm64: dts: renesas: rzg2l-smarc: Add support for enabling MTU3
      arm64: defconfig: Enable Renesas MTU3a PWM config
      mfd: rz-mtu3: Replace raw_spin_lock->spin_lock()
      mfd: rz-mtu3: Reduce critical sections
      mfd: rz-mtu3: Link time dependencies
      mfd: rz-mtu3: Fix COMPILE_TEST build error
      pwm: rz-mtu3: Fix build warning 'num_channel_ios' not described
      clk: renesas: r9a07g043: Add MTU3a clock and reset entry
      dmaengine: sh: rz-dmac: Fix destination and source data size setting
      dmaengine: sh: rz-dmac: Improve cleanup order in probe()/remove()
      arm64: dts: renesas: rzg2lc-smarc-som: Enable PMIC and built-in RTC
      arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
      arm64: defconfig: Enable PMIC RAA215300 and RTC ISL 1208 configs
      rtc: isl1208: Fix incorrect logic in isl1208_set_xtoscb()
      rtc: isl1208: Simplify probe()
      regulator: raa215300: Add missing blank space
      regulator: raa215300: Change rate from 32000->32768
      regulator: raa215300: Add const definition
      regulator: raa215300: Fix resource leak in case of error
      regulator: raa215300: Change the scope of the variables {clkin_name, =
xin_name}
      regulator: raa215300: Update help description
      i2c: Add i2c_get_match_data()
      clk: fixed-rate: add devm_clk_hw_register_fixed_rate
      rtc: destroy mutex when releasing the device
      rtc: isl1208: Fix clock tick timed out message
      pinctrl: renesas: rzv2m: Fix NULL pointer dereference in
rzv2m_dt_subnode_to_map()
      pinctrl: renesas: rzg2l: Fix NULL pointer dereference in
rzg2l_dt_subnode_to_map()

Best regards,
   Nobuhiro


