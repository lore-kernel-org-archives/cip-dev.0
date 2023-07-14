Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C68EB64DA
	for <webhook@archiver.kernel.org>; Fri, 14 Jul 2023 11:24:23 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.16656.1689333861009053954
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Jul 2023 04:24:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 36EBNteS3147906; Fri, 14 Jul 2023 20:23:55 +0900
X-Iguazu-Qid: 2rWhDvohsW77MWTZSK
X-Iguazu-QSIG: v=2; s=0; t=1689333835; q=2rWhDvohsW77MWTZSK; m=5vC/iy6x5CEs3z6rh9sW4q3EGAzGtidCFQZjxjjIM1E=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 36EBNqSW3911993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 14 Jul 2023 20:23:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1ivDKnqT6IX064OymT//pBmX6ECFjDZ+hxTbJGT62aU84hDY5bINMOmPsi4ycH7gm+q0nXuc9gL609u96xzaeMIL6kOnV0RNCBeLVpeF+CmUQEYlVKodb5aA0MI+E7SgfPS+t6nLW7lC954BLoyeJv/IBB2VuNFWt5PsvioRveCwXCEYAQLXLh8jNX7D59SrLZTD90/sX8x4qZlLb/gB/7cqF2WYjBmvDZULv4OvVdqPr5wMc1KffUTClrFjYoKt0iwYHlnXQ0vkKJWlpuqtgdwmlqCWlUpPH9gFz764dERR2T7UhtTg+PtLfS/xTtOJpXV3UNEaDqZtqZaIzPKSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VsdElcjgdCdtAJUXwuUYg3a5USNzU//bf0/FB54QuNM=;
 b=hy2WtwJ6pZF8uP7lp6JomabRZxpIl29BxGdNSMV+v/84HaNCaH4KFazQdymdlM4hGm/JF34IklMfVRnTR+YfmLaYVpm9YeNpsIal/0p5CGpR+Ty854FTqd9DkrS7PqjFkGTO21JMCrQSVvUUJ2M97qj+UN0xlBWVhgpxpiVDOD6Hows2zeqq7gAGRpQ44CkQq2tDKUk+ZFUPHImX84wN4h/cnGCFI5dmlnMvH/vnSPE0pKQFMLgonBYbY2CDPhAchsAAdCb8PH3wVxmtSheYu1VuYvWfBTsCTsWPmLZ+OEiey05NRi8K6yMpl5XWKoc+TzAgwarerz7+s55doeSQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>, <pavel@denx.de>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v6.1.38-cip1 / First release of the CIP 6.1.y
 Linux kernel
Thread-Topic: [ANNOUNCE] Release v6.1.38-cip1 / First release of the CIP 6.1.y
 Linux kernel
Thread-Index: Adm2Oa8DyAvq/6AcTfGlWf9JwSVyqg==
Date: Fri, 14 Jul 2023 11:23:50 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94202EFBF533716D771F9E9E9234A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYVPR01MB11180:EE_
x-ms-office365-filtering-correlation-id: 3c5060b5-fd72-4ed4-3816-08db845ccc81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZYnRi10NgCwHstwlry+j047wb5lOUXWAaBkzEXT9ULJkOrA+8hm+M3SkX1xV6AtfJrT3vza12EoYFsksh5LDzBg5c2ws1GDzzP/HSv/ghefNmQSR0pPJKMU+A78s852F4ttU2mL+PIvLoeV667MAQ1EDDck+a5PtUu50VvtwWdaF5o/VIAk9hQmvxzr2AhLQZsl9IQfaHdYAb9Q+Dqh4xJ8cJzeOI2DeSfe6HeY014xy8ax2XUhY67OrnkwJkkQ9vfLIM27lUMqITpKTsdgNuLkOjvD4lSQLHAXOXrQbMg+9N5cODTRnGzmAMvAvVnhSFQNc/PVc2VCJyyqDMsyHEXkwRIyPZ3QEu+cZ5/Ww0epBjfvFzx7qsBsoBJM27BcH8ES92KB5ogzbH3vEf4/9JPmQF56XDP2ZLeEoQ0/RpSvyLFbeS7mXgIZBDCTd5AtJa8t3pYu5H80jRTLC8GbUvfntW0TUVeS6YmsBjL/4c3ghmC2tdRaPe172HBo61NFw53GqEpa/ewvcVu+syNmN8lG1Gznn3sE0kqY0ckhnSnh+C7uH/jJwUqoiDeUGFPpnXsLejfCksMq+GLpzmY/c7cptMp+Vb9Ikc/es7wlcZgELNRVCwOL0SuZvBP4jgCprYicgC3hOahANiWUSYf5QHg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199021)(55016003)(83380400001)(2906002)(71200400001)(66476007)(64756008)(66446008)(7696005)(478600001)(4326008)(76116006)(966005)(9686003)(316002)(6916009)(66946007)(66556008)(52536014)(54906003)(26005)(6506007)(186003)(8676002)(41300700001)(5660300002)(8936002)(122000001)(38100700002)(86362001)(38070700005)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?UC9PbGhPbFhZbUpIUWlKMm12NHJxK0I2SEtCWmxyajV3V3JtUjYwMWx5?=
 =?iso-2022-jp?B?OG82dHovMk9kWXN0dE5xT0g3Uk4yMzBnWldpVEhZUTE5OXlpNy9vRW45?=
 =?iso-2022-jp?B?TTZmZlNWT0xGazhXam9rZHJxQ2tObzAvd25wOWI3RWUvVkRJV3hpaDlF?=
 =?iso-2022-jp?B?d1pzRmlWK25FR1pNZERrRjVlMlJxdzNwUGtuTk5Gc0MybEZZWlhpZU1Z?=
 =?iso-2022-jp?B?eWVjdm1PaWpXSlVIak9XcDk5MTFaQlVidE9GYXlWQkhhSjN0L0ZuNXZ3?=
 =?iso-2022-jp?B?cnV6cFRobERmci9INjFwY1Zka3NITmlaRzVwTWV1M2laK01GRHMrQ1pZ?=
 =?iso-2022-jp?B?S2FsQjhRTDJrSXhEMDJROWFpUmh3QkloTko1Sk5GdVZBNFpmS1N4ekJW?=
 =?iso-2022-jp?B?UWxwZUgyZ2FsTGh1dHFSTk01Zm1RYnAxcFRhckordkkzdHNWUHdtZ2Zw?=
 =?iso-2022-jp?B?clhzRUlMUHJpT3N0ZDU2dHFRaUpTRTlyWjY5dEtVcm9oQVREYWtIVExy?=
 =?iso-2022-jp?B?T2toNDNsS0lyclFxN0FLWUphQzJEQTNuNGFiWTNFQVdwWGUxOW16R0ZS?=
 =?iso-2022-jp?B?SER4bHR4Uy9QT1doMGxySEJFRWVvRTZOdW1vclVieERwdDBtS21lemwv?=
 =?iso-2022-jp?B?U3hKWTVOZjVCa0FOb3VSWWtWWVJnUzkrNXphQ0UwWGNYUUVwS2Z3SjQv?=
 =?iso-2022-jp?B?WFRvSnNnem9Ec0VRSGRSSFlHZjNjSGd1REdxOXlhQ2FHNmQxT2huQ3U5?=
 =?iso-2022-jp?B?dGJLQXdrNWVSdGUyUVloNjVWV0hSb01WdDUycXp5Wjd1YWpwamgyekMx?=
 =?iso-2022-jp?B?S3YwQVNIcGpMbm0vdWRVNHRqRW9sT0xEaWZkbThNWXRqU0FTU0ZSeUpl?=
 =?iso-2022-jp?B?dnZqckpUc0JrbFg5WGdPZHd0ZG44YkxPSXpVQ21ZdVpGdjdPT1I4ZVhx?=
 =?iso-2022-jp?B?SUo1blE0UEQyR0dNL2R0Q1Y0YlVxU1J4Y1Uwb0tDWU02Wm9CeGlSU3JN?=
 =?iso-2022-jp?B?WnJUWVRlRm1TOEkzZmllMnNzZmpvZ3lXcmlmbWxEOVhKTC9uWlhEK0hT?=
 =?iso-2022-jp?B?am1PSTZkNWNRSWdMait1SUh2ZG1HTjQ3U0ZQNVlGajlHL05OR0Z5QTZP?=
 =?iso-2022-jp?B?MmJuOGVhSmxxWlVjWFFQb0EvMEVSNWRFM1dDV2pwL0x4blE0UXdNdC9n?=
 =?iso-2022-jp?B?L1d1amJaWjUzU3dobUorVzZ5SWlHS2JSRkp3RTA2bTI4elRhV2g0eS9r?=
 =?iso-2022-jp?B?aVVoeWJTZ1lwVTRkaHBkOUZVV01qaHVVUnZQbS85YlNaZExvTGZUeU8x?=
 =?iso-2022-jp?B?OEdsVkNJbTlBOGJHM3VJUHM3dDNGd0c2WFVJaFFjc0p1ZWoyUTkrS3pL?=
 =?iso-2022-jp?B?MS96QndNblNyeEF4VkJDMFdRNEdDb2YyWmpkSkl4dnpwQjdTRVBXYnRm?=
 =?iso-2022-jp?B?ck5PbDdncUJIOGt0dkNVOU5GUUtlK01LTFkrVG1PcFE1SzNzUHRTTTdy?=
 =?iso-2022-jp?B?bWc1dVJtSC96bG9IQWF6SXhSRnR6ZGFJRkZLQy9Qc1Z6bGNjVjNpa3BX?=
 =?iso-2022-jp?B?WUdlUitGZTc1OVV0dWxtRWw5WnUrOTA3Wis5VGZ4RFJsV1VVbUdRQUpn?=
 =?iso-2022-jp?B?enY1Si9hUjE2ekZteXVyNktCaEpLeFU2Y1hsakxJSE5lSk5BdGoxM3J6?=
 =?iso-2022-jp?B?T2NHVUc4TDZvcTdMVjlhTmJ3czhjQjg2QjlVS1FoM2ZNUUZZUlBRU2Vr?=
 =?iso-2022-jp?B?QkUxcVlhTHdDZVROZ2lFeCtqUmZQa2JaclJPUDZ4L0puZlNXaFdVNXMr?=
 =?iso-2022-jp?B?L0poVWFVQ0M3cVAxSXJ5L1hQN01VQ0pKK2NreUlEaEpkVEx1LzJvT2h5?=
 =?iso-2022-jp?B?N3pFNFBzaklvN01BUHpLZGhlSHFWU21Ja2pXRG1qak53bFFHaENZSDc4?=
 =?iso-2022-jp?B?amVCVWZGNFdzSE1mMUdNbGdMQlBQOHNQdVExNVJUQndjcXZxSmpnWVJ6?=
 =?iso-2022-jp?B?M3B2WUtVQ1VFcEZWamxkZXYrNm05dFVCcTRSZ1A3Njc0NGt1Y3lCdTdn?=
 =?iso-2022-jp?B?M2t0T3JMK3NnNGRtTEpXZjBUUTRJZ2kvcDVLY0lCZFA4bG1tR254Vko3?=
 =?iso-2022-jp?B?ZFZBUGUydzNzUmNQRnJrdysxUHNBUkNIZi9nalA2Y2IrU3djZ1hicGtI?=
 =?iso-2022-jp?B?SFVRK01veitEU25XOGFKbW9xSmV4VlUwbHk0UTVyNUZ1UTFJVnFOY0s5?=
 =?iso-2022-jp?B?UjRvSWxFWjN5NEhuQmRCL2tGL0tNZC9vUlhrSGlKSkwrMjJqUXFyQkpU?=
 =?iso-2022-jp?B?TDBkOXNuRE11THcrVFpWb1NmcmpWV0Zsd0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?iso-2022-jp?B?dTBQVTFjOXkzeFl4NHNlTkFKVVYxNGFrcGpHL3VLUzN3SEJtendtbGd2?=
 =?iso-2022-jp?B?aXYyVzNSZERXNWo3UHJOa3M1NFFZYlNQQTlCQnE1bWI0ZmJsQXhwdEpD?=
 =?iso-2022-jp?B?ZlllaFpFVkNqNVRGeEdKM1BOR2FhcE83VzNicGt2NnU3MGZvdHMxekU3?=
 =?iso-2022-jp?B?VWZIM1lrUElwVW5pMzZpYlYycnc4UHRZZUUxeXQ2UXJxVkt0alFyVHlB?=
 =?iso-2022-jp?B?ZUJGYjNZS3lkd1JuR0NCbUZKQ052N292VkgvTWkrcUJoUkpPanBINDM1?=
 =?iso-2022-jp?B?ZnhZdmlUVkhCQWtUOThhODh4aWZvVnc2bGtHMjJLdnFhMmhmSGc3YVo2?=
 =?iso-2022-jp?B?enFXRDR6bkt6OU1hbndiTnZja0FRVmZBYysrVWFXSG1oNUhKUCs1QVl2?=
 =?iso-2022-jp?B?RzBBKy9TbHAraWlPaHZJVzRzbXg1TkJENXlXNGw3TFVDVlhMWHlIYzND?=
 =?iso-2022-jp?B?WXU5NzA4dklJV0tLK3l6WTJHQnAyUEkwQUozNWtiYitDdHc5UTlFRnJs?=
 =?iso-2022-jp?B?aTlwQlJsUVJSK1ZIRHlaakd4Uk1wL25CbHFxdExtS0Vib1hjYU9VSmFO?=
 =?iso-2022-jp?B?L0RVNWN3MGdhYit3cUwwVGQ1SFdmWkZtNVBtekc0NllnWEFYSWpOWEdH?=
 =?iso-2022-jp?B?cjhteXBLV1NLck4zdndFc2ttWEFxc3ZxQU5JRWNMU3dwQ1lXcmp0S3h4?=
 =?iso-2022-jp?B?aGoxWjhSYkJjRkI4MWRFVTdEVkJZdE5TR1Nra3FreGhyQXFwZWhpcTNv?=
 =?iso-2022-jp?B?MzZwSCsrNGtSVGtyTkFmUFhzaUZFeG5GTUhlZlRaay9IcFFuRDlyU2R5?=
 =?iso-2022-jp?B?a2tYZmhtSS9xUXNxcjNiWUNzcHBFd3U3elI5aFhvT2FCNDhrcUUrbHFv?=
 =?iso-2022-jp?B?Z1p2RG00N0xzeHpNR05melBvRUMvd1IrSEZKbDhmc212VjRaU0lac2Mz?=
 =?iso-2022-jp?B?cnRrMlFGdlVOVXRwdkdEMFhqNGJmYzBRczByM2RlMGVDMkl5bDFMbGR2?=
 =?iso-2022-jp?B?SHp4WXRsN1dGNTM0SVd6V0U0ZHQrVlpqL0NFc3NRSWpmL2o1emlvbmxP?=
 =?iso-2022-jp?B?c2N5OXpjMVNOU0VSczh6LzJNYU1mejByWFVjWk0zeU5FMnRsaitqdU9X?=
 =?iso-2022-jp?B?M1QweTEwT1hLcmYwY3htenh6ZWdnQ29yR08vU1p3Sk9ZUnI4QXd4Y2Rh?=
 =?iso-2022-jp?B?cUxNbXh1bTZPQkE3SWhUdUp3WWVKclY1NEJ2QnV1dEc5MjRsRHZjamt3?=
 =?iso-2022-jp?B?OGdIM2I0VW1KQnZmTG5tRDAzb2ROQUZieTVTWmcrOUFPM0tBVUlkN3FW?=
 =?iso-2022-jp?B?cys2YzQ3a0srY0xjTVZkS0V1ZUg2NnF0MFQ2NlVJV25LZFcwOGN0WURh?=
 =?iso-2022-jp?B?Y3pyUTd1aXgremlJQmJFZz09?=
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5060b5-fd72-4ed4-3816-08db845ccc81
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2023 11:23:50.5746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c2V9iS/UU5XrAoUlig7gjgeQd8M4MbT1/2+XsSbzsblb10Ef7UbCJXpOrOajDH4nG84t42xQqxyPfS9A/gmlx8xRlM6s6iiUeZR5mJkGtj4JMCXdDBfm95er7LkPTBtZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11180
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Jul 2023 11:24:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12347

Hi all,

We releases v6.1.38-cip1, which is the first release of the CIP 6.1.y Linux=
 kernel!
This is based on v6.1.38 with many additional updates for the Renesas ARM64=
 SoC and=20
reference boards.

You can get this release via the git tree at:

  v6.1.38-cip1:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      b75089afeb2c1427e22539443d7498b221bdeaf4
    added commits:
      cip: Add a number to the version suffix
      usb: gadget: udc: renesas_usb3: Fix RZ/V2M {modprobe,bind} error
      i2c: rzv2m: Disable the operation of unit in case of error
      i2c: rzv2m: Replace lowercase macros with static inline functions
      i2c: rzv2m: Drop extra space
      arm64: dts: renesas: r9a07g054: Add MTU3a node
      arm64: dts: renesas: r9a07g044: Add MTU3a node
      MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver
      counter: Add Renesas RZ/G2L MTU3a counter driver
      Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and =
external_input_phase_clock_select
      mfd: Add Renesas RZ/G2L MTU3a core driver
      dt-bindings: timer: Document RZ/G2L MTU3a bindings
      clk: renesas: r9a07g044: Add MTU3a clock and reset entry
      arm64: dts: renesas: rzv2mevk2: Add uart0 pins
      serial: 8250_em: Add serial8250_em_{reg_update(),out_helper()}
      serial: 8250_em: Use pseudo offset for UART_FCR
      serial: 8250_em: Use devm_clk_get_enabled()
      serial: 8250_em: Add missing break statement
      serial: 8250_em: Drop unused header file
      serial: 8250_em: Simplify probe()
      dt-bindings: usb: ti,hd3ss3220: Update interrupt property as optional
      arm64: dts: renesas: rzg2ul-smarc: Enable SCI0
      can: rcar_canfd: Add multi_channel_irqs to struct rcar_canfd_hw_info
      can: rcar_canfd: Add postdiv to struct rcar_canfd_hw_info
      can: rcar_canfd: Add shared_global_irqs to struct rcar_canfd_hw_info
      can: rcar_canfd: Add max_channels to struct rcar_canfd_hw_info
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA rx support
      tty: serial: sh-sci: Add RZ/G2L SCIFA DMA tx support
      tty: serial: sh-sci: Remove setting {src,dst}_{addr,addr_width} based=
 on DMA direction
      tty: serial: sh-sci: Fix end of transmission on SCI
      tty: serial: sh-sci: Add support for tx end interrupt handling
      tty: serial: sh-sci: Fix TE setting on SCI IP
      arm64: defconfig: Enable RZ/V2M xHCI and USB3.1 DRD controller suppor=
t
      arm64: dts: renesas: rzv2mevk2: Enable USB3 role switch
      arm64: dts: renesas: rzv2mevk2: Enable USB3 DRD, Peripheral and Host
      arm64: dts: renesas: r9a09g011: Add USB3 DRD, device and host nodes
      xhci: split out rcar/rz support from xhci-plat.c
      xhci: host: Add Renesas RZ/V2M SoC support
      usb: host: xhci-plat: Add reset support
      usb: host: xhci-plat: Improve clock handling in probe()
      usb: gadget: udc: renesas_usb3: Add role switch support for RZ/V2M
      usb: gadget: Add support for RZ/V2M USB3DRD driver
      dt-bindings: usb: Add RZ/V2M USB3DRD binding
      dt-bindings: usb: renesas,usb3-peri: Document RZ/V2MA bindings
      dt-bindings: usb: renesas,usb3-peri: Update reset, clock-name and int=
errupts properties
      dt-bindings: usb: renesas,usb-xhci: Document RZ/V2M support
      usb: typec: hd3ss3220: Add polling support
      clk: renesas: r9a09g011: Add USB clock and reset entries
      dt-bindings: i2c: renesas,rzv2m: Change maintainer to Fabrizio Castro
      arm64: dts: renesas: rzv2mevk2: Enable watchdog
      arm64: dts: renesas: r9a09g011: Add watchdog node
      arm64: dts: renesas: r9a09g011: Add system controller node
      arm64: dts: renesas: r9a09g011: Add L2 Cache node
      arm64: dts: renesas: r9a09g011: Reword ethernet status
      clk: renesas: r9a09g011: Add TIM clock and reset entries
      arm64: dts: renesas: rzg2l: Add clock-names and reset-names to DMAC n=
odes
      dmaengine: sh: rz-dmac: Remove unused rz_dmac_chan.*_word_size
      dmaengine: sh: rz-dmac: Add reset support
      dt-bindings: dma: rz-dmac: Document clock-names and reset-names
      soc: renesas: Identify RZ/V2M SoC
      dt-bindings: arm: renesas: Document Renesas RZ/V2M System Configurati=
on
      pinctrl: renesas: rzg2l: remove unnecessary check from rzg2l_dt_node_=
to_map()
      can: rcar_canfd: rcar_canfd_probe: Add struct rcar_canfd_hw_info to d=
river data
      can: rcar_canfd: Use devm_reset_control_get_optional_exclusive
      clk: renesas: rzg2l: Support sd clk mux round operation
      Add configuration for gitlab-ci.

Best regards,
   Nobuhiro


