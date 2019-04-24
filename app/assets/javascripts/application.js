// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery.min
//= require turbolinks
//= require popper.min
//= require bootstrap.min
//= require summernote/summernote-bs4.min
//= require summernote-init
//= require grasp_mobile_progress_circle-1.0.0.min
//= require jquery.cookie
//= require jquery.validate.min
//= require jquery.mCustomScrollbar.concat.min
//= require ladda-spin
//= require ladda.min
//= require ladda.jquery
//= require toastr.min
//= require front
//= require slimscroll
//= require dropzone
//= require chatbox_dropzone
//= require nestable
//= require cable
//= require watcher
//= require chosen
//= require metisMenu
//= require moment
//= require bootstrap-datepicker
//= require dropzone_initializer
//= require jquery-te-1.4.0.min
//= require tagsinput
//= require bootstrap-notify.min
//= require Chart.min
//= require cocoon
//= require color_admin
//= require awesome_complete
//= require jquery-ui/widgets/autocomplete
//= require autocomplete-rails
//= require select2.min
//= require pdfjs
//= require cropper
//= require Timer
//= require footable.min

$(document).on("turbolinks:load", function() {
  $(".selectpicker").selectpicker();
  // $(".selectpicker2").selectpicker();
  $(".categories").selectpicker();
  $(".brandpicker").selectpicker();
  $(".clone_categories").selectpicker();
  $(".clone_products").selectpicker();
  $(".existing_product").selectpicker();

  $(function() {
    $('[data-toggle="tooltip"]').tooltip();
    $(".dropdown").bind("keydown", function(event) {
      if (event.keyCode === 9) {
        $(this)
          .find(".selectpicker")
          .selectpicker("toggle");
        // $(this)
        //   .find(".selectpicker2")
        //   .selectpicker("toggle");
        $(this)
          .find(".categories")
          .selectpicker("toggle");
        $(this)
          .find(".brandpicker")
          .selectpicker("toggle");
        $(this)
          .find(".clone_categories")
          .selectpicker("toggle");
        $(this)
          .find(".clone_products")
          .selectpicker("toggle");
      }
    });
    $("#view_history").click(function() {
      $("#viewHistories").modal("show");
    });

    $("select.existing_product").on("change", function(e) {
      $.ajax({
        method: "GET",
        url: "/orders/item_details?id=" + this.value
      }).done(function(data) {
        $("#order_product_details").html("");
        $("#order_product_details").html(data);
      });
    });
  });

  $(".onlyNumbers").on("keypress keyup blur", function(event) {
    var charCode = event.which ? event.which : event.keyCode;
    if (
      charCode > 31 &&
      (charCode < 48 || charCode > 57) &&
      !(charCode == 46 || charCode == 8)
    )
      event.preventDefault();
    else {
      var len = $(this).val().length;
      var index = $(this)
        .val()
        .indexOf(".");
      if (index > 0 && charCode == 46) {
        event.preventDefault();
      }
      if (index > 0) {
        var CharAfterdot = len + 1 - index;
        if (CharAfterdot > 3 && !(charCode == 46 || charCode == 8)) {
          event.preventDefault();
        }
      }
    }
  });
});

var room = 1;

function product_attributes() {
  room++;
  var objTo = document.getElementById("product_attributes");
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="order_field_name" value="" placeholder="Attribute Name"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="order_field_value" value="" placeholder="Attribute Value"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  objTo.appendChild(divtest);
}

function clone_product_attributes() {
  room++;
  var objTo = document.getElementById("clone_product_attributes");
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="clone_order_field_name" value="" placeholder="Attribute Name"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="clone_order_field_value" value="" placeholder="Attribute Value"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  objTo.appendChild(divtest);
}

function clone_product_attributes_2(key, val) {
  room++;
  var objTo = document.getElementById("clone_product_attributes");
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="clone_order_field_name" placeholder="Attribute Name" value="' +
    key +
    '"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="clone_order_field_value" placeholder="Attribute Value" value="' +
    val +
    '"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  objTo.appendChild(divtest);
}

function add_product_attributes() {
  room++;
  var objTo = document.getElementById("add_product_attributes");
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="add_order_field_name" value="" placeholder="Attribute Name"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="add_order_field_value" value="" placeholder="Attribute Value"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  objTo.appendChild(divtest);
}

function generate_attributes(key, val, element) {
  room++;
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="order_field_name" placeholder="Attribute Name" value="' +
    key +
    '"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="order_field_value" placeholder="Attribute Value" value="' +
    val +
    '"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  $(element).append(divtest);
}

function add_attribute(element) {
  room++;
  var divtest = document.createElement("div");
  divtest.setAttribute("class", "row form-group removeclass" + room);
  var rdiv = "removeclass" + room;
  divtest.innerHTML =
    '<div class="col-md-4 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_name][]" name="order_field_name" value="" placeholder="Attribute Name"></div></div><div class="col-md-6 nopadding"><div class="form-group"> <input type="text" class="form-control" id="order[field_value][]" name="order_field_value" value="" placeholder="Attribute Value"></div></div><div class="col-md-2 nopadding"><div class="form-group"> <button class="btn btn-outline-danger" type="button" onclick="remove_education_fields(' +
    room +
    ');"> <span class="fa fa-trash" aria-hidden="true"></span> </button></div></div><div class="clear"></div>';

  $(element).append(divtest);
}

function remove_education_fields(rid) {
  $(".removeclass" + rid).remove();
}

function onSearchFilter() {
  // Declare variables
  var input, filter, div, buttons, btn, i;
  input = document.getElementById("filterSearch");
  filter = input.value.toUpperCase();
  div = document.getElementsByClassName("item-list");
  buttons = div[0].getElementsByTagName("button");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < buttons.length; i++) {
    btn = buttons[i];
    if (btn) {
      if (btn.innerHTML.toUpperCase().indexOf(filter) > -1) {
        btn.style.display = "";
      } else {
        btn.style.display = "none";
      }
    }
  }
}

function submitForm(id, elem) {
  form_id = "#" + id;
  $(form_id).submit();
  $(elem).attr("disabled", "disabled");
  $(elem).html("Please Wait...");
}

function showEditOrderEntries() {
  $("#editOrderEntries").modal("show");
}

function showEditOrder(id) {
  $.ajax({
    method: "GET",
    url: "/api/simple/orders/" + id
  }).done(function(data) {
    $("#edit_order")
      .find("#order_id")
      .val(data.id);
    $("#edit_order")
      .find("#order_status")
      .val(data.status);
    $("#edit_order")
      .find("#order_brand_id")
      .val(data.brand_id);
    $("#edit_order")
      .find("#order_total_budget")
      .val(data.total_budget);
    $("#edit_order")
      .find("#order_lead_time")
      .val(data.lead_time);
    $("#editOrder").modal("show");
    $(".selectpicker").selectpicker("refresh");
  });
}
function setFormValues(data, form) {
  $(form)
    .find("#order_entry_id")
    .val(data.id);
  $(form)
    .find("#order_entry_category_id")
    .val(data.category_id);
  $(form)
    .find("#order_entry_vendor")
    .val(data.vendor_list);
  $(form)
    .find("#order_entry_product_id")
    .val(data.product_id);
  $(form)
    .find("#order_entry_quoted_by")
    .val(data.quoted_by);
  $(form)
    .find("#order_entry_price")
    .val(data.price);
  $(form)
    .find("#order_entry_cost")
    .val(data.cost);
  $(form)
    .find("#order_entry_tax")
    .val(data.tax);
  $(form)
    .find("#order_entry_quantity")
    .val(data.quantity);
  $(form)
    .find("#order_entry_specs")
    .val(data.specs);
  $(form)
    .find("#order_entry_vendor_quote_prices")
    .val(data.vendor_quote_prices);
  $(form)
    .find("#order_entry_notes")
    .val(data.notes);
  var element = $(form).find("#product_attributes");
  element.html("");
  if (
    data.convert_dynamic_fields != "" &&
    data.convert_dynamic_fields != null &&
    data.convert_dynamic_fields != undefined
  ) {
    foo = JSON.parse(data.convert_dynamic_fields);
    Object.keys(foo).forEach(function eachKey(key) {
      generate_attributes(key, foo[key], element);
    });
  }
  $(".selectpicker2").selectpicker("refresh");
  $(".selectpicker").selectpicker("refresh");
}

function setVendors(btn_type, current_user_name) {
  if ($(".item_ids").is(":checked")) {
    var formData = $("#form_order_checklist").serialize();

    $.ajax({
      type: "GET",
      url: "/order_entries/list",
      data: formData
    }).done(function(data) {
      if (btn_type === "request_quote") {
        $(".textarea-format").jqteVal(textContentQuote + data + "<br/>");
      } else if (btn_type === "create_order") {
        $(".textarea-format").jqteVal(textContentOrder + data + "<br/>");
      }
    });

    $.ajax({
      type: "GET",
      url: "/api/simple/order_entries/vendor_email_list",
      data: formData
    }).done(function(data) {
      $("#email_template_btn_type").val(btn_type);
      var arr = data[0];
      $("#new_email_template")
        .find("#email_template_to")
        .tagsinput("removeAll");
      jQuery.each(arr, function(i, val) {
        $("#new_email_template")
          .find("#email_template_to")
          .tagsinput("add", val);
        console.log(val);
      });
      $("#new_email_template")
        .find("#email_template_order_entry_ids")
        .val(data[1]);
      $("#requestQuote").modal("show");
    });
    $.ajax({
      type: "GET",
      url: "/api/simple/order_entries/attachment_list",
      data: formData
    }).done(function(data) {
      console.log(data);
      var removedItems = [];
      var emailPreviewDropzone = new Dropzone("#new_email_template", {
        url: "/email_templates",
        addRemoveLinks: true,
        autoProcessQueue: false,
        uploadMultiple: true,
        parallelUploads: 10,
        maxFiles: 10,
        previewsContainer: "#dropzoneEmailPreview",
        clickable: "#dropzoneEmailPreview",

        // The setting up of the dropzone
        init: function() {
          var myDropzone = this;
          myDropzone = this; // closure
          $.each(data, function(i, currAttachment) {
            var mockFile = {
              name: currAttachment.attachment_file_file_name,
              size: parseInt(currAttachment.attachment_file_file_size),
              id: currAttachment.id
            };
            myDropzone.emit("addedfile", mockFile);
            myDropzone.emit("complete", mockFile);
            myDropzone.files.push(mockFile);
          });
          this.element
            .querySelector("button[type=submit]")
            .addEventListener("click", function(e) {
              // Make sure that the form isn't actually being sent.
              e.preventDefault();
              e.stopPropagation();
              $("#email_template_removed_attachments").val(removedItems);
              if (myDropzone.getQueuedFiles().length === 0) {
                $("#new_email_template").submit();
              } else {
                myDropzone.processQueue();
              }
            });
          $("#requestQuote").on("hidden.bs.modal", function(e) {
            console.log("working...");
            myDropzone.destroy();
          });
          this.on("successmultiple", function(files, response) {
            var data = response;
            location.reload(true);
          });
        },
        removedfile: function(file) {
          console.log(file);
          removedItems.push(file.id);
          var ref;
          return (ref = file.previewElement) != null
            ? ref.parentNode.removeChild(file.previewElement)
            : void 0;
        }
      });
    });
  }
}
function itemDetails(id, entry_id) {
  $.ajax({
    method: "GET",
    url: "/api/simple/order_entries/" + entry_id
  }).done(function(data) {
    $("#add_product_attributes").html("");
    $("#add_product_id").val(data.product_id);
    $("#add_product_id_2").val(data.product_id);
    $("#order_entry_id_2").val(entry_id);
    $("#order_entry_id_3").val(entry_id);
    $("#pic1").attr("src", data.product_picture);
    $(".product-name-header").html("(" + data.product.name + ")");

    $("#order-entry-details").html("");
    checkDataValue("Product", data.product.name);
    checkDataValue("Category", data.category.name);
    checkDataValue("Vendor", data.vendor_name);
    checkDataValue("Hotel Price", data.price);
    checkDataValue("Vendor Cost", data.cost);
    checkDataValue("Tax", data.tax);
    checkDataValue("Quantity", data.quantity);
    setFormValues(data, $("#edit_order_entry"));

    var editProductDropzone = new Dropzone("#edit_order_entry", {
      url: "/order_entries/update_entry",
      addRemoveLinks: true,
      autoProcessQueue: false,
      uploadMultiple: true,
      parallelUploads: 10,
      maxFiles: 10,
      previewsContainer: "#dropzoneEditPreview",
      clickable: "#dropzoneEditPreview",

      // The setting up of the dropzone
      init: function() {
        var myDropzone = this;
        myDropzone = this; // closure
        $.each(data.attachments, function(i, currAttachment) {
          var mockFile = {
            name: currAttachment.file_name,
            size: parseInt(currAttachment.file_size),
            id: currAttachment.id
          };
          myDropzone.emit("addedfile", mockFile);
          myDropzone.emit("complete", mockFile);
          myDropzone.files.push(mockFile);
        });
        this.element
          .querySelector("button[type=submit]")
          .addEventListener("click", function(e) {
            // Make sure that the form isn't actually being sent.
            e.preventDefault();
            e.stopPropagation();
            if (myDropzone.getQueuedFiles().length === 0) {
              $("#edit_order_entry").submit();
            } else {
              setAttributesOnForm($("#edit_order_entry"));
              myDropzone.processQueue();
            }
          });
        $("#close-item-details").on("click", function(e) {
          $("#viewProducts").modal("hide");
          myDropzone.destroy();
        });
        this.on("successmultiple", function(files, response) {
          // Gets triggered when the files have successfully been sent.
          // Redirect user or notify of success.
          var data = response;
          location.reload(true);
        });
      },
      removedfile: function(file) {
        if (!this.disabled) {
          console.log(file);
          $.ajax({
            type: "POST",
            url: "/api/simple/order_entries/destroy_attachment",
            data: { id: file.id }
          }).done(function(data) {});
        }

        var ref;
        return (ref = file.previewElement) != null
          ? ref.parentNode.removeChild(file.previewElement)
          : void 0;
      }
    });

    if (data.specs != "" && data.specs != null && data.specs != undefined) {
      $("#nav-specs").html(data.specs_html);
      $("#add_specs").val(data.specs_html);
    }
    if (
      data.vendor_quote_prices != "" &&
      data.vendor_quote_prices != null &&
      data.vendor_quote_prices != undefined
    ) {
      $("#nav-quotes").html(data.vendor_quote_prices_html);
      $("#add_vendor_quote_prices").val(data.vendor_quote_prices_html);
    }
    if (data.notes != "" && data.notes != null && data.notes != undefined) {
      $("#nav-notes").html(data.notes_html);
      $("#add_notes").val(data.notes_html);
    }
    $("#dynamic-attributes").html("");
    if (
      data.convert_dynamic_fields != "" &&
      data.convert_dynamic_fields != null &&
      data.convert_dynamic_fields != undefined
    ) {
      foo = JSON.parse(data.convert_dynamic_fields);
      Object.keys(foo).forEach(function eachKey(key) {
        dynamic_attributes = $("#dynamic-attributes").html();
        $("#dynamic-attributes").html(
          dynamic_attributes + generateTableRow(key, foo[key])
        );
      });
    } else {
      $("#dynamic-attributes").html("No Attributes Available");
    }

    $.ajax({
      method: "GET",
      url: "/order_entries/history?id=" + entry_id
    }).done(function(data) {
      $("#order_entry_histories").html("");
      $("#order_entry_histories").html(data);
      $("#viewProducts").modal("show");
    });
  });
}

function generateAttachments(order_entry_id) {
  $.ajax({
    method: "GET",
    url: "/order_entries/attachment?id=" + order_entry_id
  }).done(function(data) {
    $("#order_entry_attachments").html("");
    $("#order_entry_attachments").html(data);
    $("#viewAttachments").modal("show");
  });
}

function generateTableRow(key, value) {
  return (
    "<tr style='margin-bottom: 2%'><td> <span class='float-left'>" +
    key +
    "</span> <span class='float-right'>" +
    value +
    "</span></td></tr>"
  );
}

function checkDataValue(key, value) {
  if (value != "null" && value != "" && value != null && value != undefined) {
    $("#order-entry-details").html(
      $("#order-entry-details").html() + generateTableRow(key, value)
    );
  } else {
    $("#order-entry-details").html(
      $("#order-entry-details").html() + generateTableRow(key, "")
    );
  }
}

function openEditAttributes() {
  $("#viewProducts").modal("hide");
  $("#editAttributes").modal("show");
}

function openViewItems() {
  $("#editFreeFlow").modal("hide");
  $("#editAttributes").modal("hide");
  $("#viewProducts").modal("show");
}

function openEditFreeFlow() {
  $("#viewProducts").modal("hide");
  $("#editFreeFlow").modal("show");
}

function submitEditAttributes() {
  var product_id = $("#add_product_id").val();
  var entry_id = $("#order_entry_id_3").val();
  var dynamic_fields = {};
  var field_names = $("input[name=add_order_field_name]");
  var field_values = $("input[name=add_order_field_value]");

  for (var i = field_names.length - 1; i >= 0; i--) {
    dynamic_fields[$(field_names[i]).val()] = $(field_values[i]).val();
  }
  $.ajax({
    method: "POST",
    url: "/api/simple/products/update_product",
    data: {
      id: product_id,
      dynamic_fields: dynamic_fields
    }
  }).done(function(data) {
    $("#editAttributes").modal("hide");
    itemDetails(data.id, entry_id);
  });
}

function submitEditFreeFlow() {
  var product_id = $("#add_product_id").val();
  var entry_id = $("#order_entry_id_3").val();
  var specs = $("#add_specs").val();
  var vendor_quote_prices = $("#add_vendor_quote_prices").val();
  var notes = $("#add_notes").val();
  $.ajax({
    method: "POST",
    url: "/api/simple/products/update_product",
    data: {
      id: product_id,
      specs: specs,
      vendor_quote_prices: vendor_quote_prices,
      notes: notes
    }
  }).done(function(data) {
    $("#editFreeFlow").modal("hide");
    itemDetails(data.id, entry_id);
  });
}

function setAttributesOnForm(element) {
  var dynamic_fields = {};

  var field_names = $(element).find("input[name=order_field_name]");
  var field_values = $(element).find("input[name=order_field_value]");

  for (var i = field_names.length - 1; i >= 0; i--) {
    dynamic_fields[$(field_names[i]).val()] = $(field_values[i]).val();
  }

  $(element)
    .find("#dynamic_fields")
    .val(JSON.stringify(dynamic_fields));
  return true;
}

function setCloneAttributesOnForm(element) {
  var dynamic_fields = {};

  var field_names = $(element).find("input[name=clone_order_field_name]");
  var field_values = $(element).find("input[name=clone_order_field_value]");

  for (var i = field_names.length - 1; i >= 0; i--) {
    dynamic_fields[$(field_names[i]).val()] = $(field_values[i]).val();
  }

  $(element)
    .find("#clone_dynamic_fields")
    .val(JSON.stringify(dynamic_fields));
  return true;
}

function setAttribute(field_name, field_value) {
  var element = $("#" + field_name);
  var field_elem = $(element).find("input[name=order_field_value]");
  console.log(field_elem);
  $(field_elem[0]).val(field_value);
}
