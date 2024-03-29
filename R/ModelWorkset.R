#' OpenM++ Model Worksets
#'
#' Functions for creating, copying, merging, retrieving, and deleting
#'   worksets.
#'
#' @param from Source workset name.
#' @param readonly Boolean. Should workset be read-only?
#' @param csv CSV file path.
#' @param workset Workset metadata.
#' @param data Data used for the body of the request.
#' @inheritParams get_workset_param
#' @inheritParams get_model
#' @inheritParams get_run_microdata
#'
#' @return A `list`, `tibble`, or nothing (invisibly).
#'
#' @export
get_workset <- function(model, set) {
  api_path <- glue::glue('api/model/{model}/workset/{set}/text')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
get_worksets_list <- function(model) {
  api_path <- glue::glue('api/model/{model}/workset-list/text')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
get_worksets <- function(model) {
  get_worksets_list(model) |>
    purrr::map(purrr::compact) |>
    purrr::map(tibble::as_tibble) |>
    purrr::list_rbind()
}

#' @rdname get_workset
#' @export
get_scenarios <- get_worksets

#' @rdname get_workset
#' @export
get_workset_status <- function(model, set) {
  api_path <- glue::glue('api/model/{model}/workset/{set}/status')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
get_workset_status_default <- function(model) {
  api_path <- glue::glue('api/model/{model}/workset/status/default')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
set_workset_readonly <- function(model, set, readonly) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/readonly/{readonly}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('POST') |>
    httr2::req_perform()
}

#' @rdname get_workset
#' @export
create_workset <- function(data) {
  api_path <- glue::glue('/api/workset-create')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_json(data, auto_unbox = TRUE) |>
    httr2::req_method('PUT') |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
merge_workset <- function(workset) {
  api_path <- glue::glue('/api/workset-merge')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_multipart(
      workset = jsonlite::toJSON(workset, auto_unbox = TRUE)
    ) |>
    httr2::req_method('PATCH') |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
update_workset_param_csv <- function(workset, csv) {
  api_path <- glue::glue('/api/workset-merge')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_multipart(
      workset = jsonlite::toJSON(workset, auto_unbox = TRUE),
      `parameter-csv` = curl::form_file(csv)
    ) |>
    httr2::req_method('PATCH') |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
replace_workset <- function(workset) {
  api_path <- glue::glue('/api/workset-replace')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_multipart(
      workset = jsonlite::toJSON(workset, auto_unbox = TRUE)
    ) |>
    httr2::req_method('PUT') |>
    httr2::req_perform() |>
    httr2::resp_body_json()
}

#' @rdname get_workset
#' @export
delete_workset <- function(model, set) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('DELETE') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
delete_workset_param <- function(model, set, name) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/parameter/{name}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('DELETE') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
update_workset_param <- function(model, set, name, data) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/parameter/{name}/new/value')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_json(data, auto_unbox = TRUE) |>
    httr2::req_method('PATCH') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
copy_param_run_to_workset <- function(model, set, name, run) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/copy/parameter/{name}/from-run/{run}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('PUT') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
merge_param_run_to_workset <- function(model, set, name, run) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/merge/parameter/{name}/from-run/{run}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('PATCH') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
copy_param_workset_to_workset <- function(model, set, name, from) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/copy/parameter/{name}/from-workset/{from}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('PUT') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
merge_param_workset_to_workset <- function(model, set, name, from) {
  api_path <- glue::glue('/api/model/{model}/workset/{set}/merge/parameter/{name}/from-workset/{from}')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_method('PATCH') |>
    httr2::req_perform()
  invisible()
}

#' @rdname get_workset
#' @export
upload_workset_params <- function(model, set, data) {
  api_path <- glue::glue('/api/upload/model/{model}/workset')
  OpenMpp$API$build_request() |>
    httr2::req_url_path(api_path) |>
    httr2::req_body_multipart(
      filename = curl::form_file(data)
    ) |>
    httr2::req_method('POST') |>
    httr2::req_perform()
  invisible()
}
