# The example questionnaires

The questionnaires that come with the app, one for each IRT model, made
with
[`questionnaire_from_mirt`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md)
(see `data-raw/examples.R`). The four ordered polytomous models use the
50 IPIP Big-Five statements fitted to the responses of 19,718 people
(Open-Source Psychometrics Project); the dichotomous and nominal models
use the 32 multiple-choice items of the SAT12 science test of `mirt`,
scored right/wrong with its key and as given, option by option.

## Usage

``` r
example_questionnaires()
```

## Value

A named character vector: the label of each questionnaire (short enough
for the dropdown of the CAT tab, which shows the full name of the model
below it) and the path of its csv.

## See also

Other questionnaire:
[`irt_models()`](https://sedzinfo.github.io/golemirt/reference/irt_models.md),
[`questionnaire_from_mirt()`](https://sedzinfo.github.io/golemirt/reference/questionnaire_from_mirt.md),
[`read_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/read_questionnaire.md),
[`validate_questionnaire_against_mirt()`](https://sedzinfo.github.io/golemirt/reference/validate_questionnaire_against_mirt.md),
[`write_questionnaire()`](https://sedzinfo.github.io/golemirt/reference/write_questionnaire.md)

## Examples

``` r
example_questionnaires()
#>                                                                IPIP-50 Big Five · RSM                                                                IPIP-50 Big Five · PCM 
#>  "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/ipip50_rsm.csv"  "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/ipip50_pcm.csv" 
#>                                                                IPIP-50 Big Five · GRM                                                               IPIP-50 Big Five · MGRM 
#>  "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/ipip50_grm.csv" "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/ipip50_mgrm.csv" 
#>                                                                   SAT12 Science · 3PL                                                                   SAT12 Science · NRM 
#>   "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/sat12_3pl.csv"   "/tmp/RtmpLAXeSb/temp_libpath8db0229fbe139/golemirt/extdata/examples/sat12_nrm.csv" 
```
